ccc
dir_parent='/lustre/maheenr/results_temp_09_13/swapAllCombos_unique_3_gt_writeAndScoreLists_html/'; 


out_dir='questions_gap';
if ~exist(out_dir,'dir')
    mkdir(out_dir)
end

k_vec=[0.01:0.01:0.1,0.2:0.1:1];

for k=k_vec

dir_master=fullfile(dir_parent,['KNN_' num2str(k) '_LOO_ratioEqual']);

ndiv_path=fullfile(dir_master,'results_by_prec_withCat_0.10109');
div_path=fullfile(dir_master,'results_by_prec_withCat_0.10109_diversity_1');


models=dir(fullfile(ndiv_path,'*.mat'));
models={models(:).name};



gap_record=struct('name',models,'gap',cell(size(models)),...
    'div',cell(size(models)),'ndiv',cell(size(models)));

matlabpool open
parfor i=1:numel(models)
    i
    div=load(fullfile(div_path,models{i}));
    ndiv=load(fullfile(ndiv_path,models{i}));
    
    cell_record=cell(2,1);
    cell_record{1}=div.record_lists;
    cell_record{2}=ndiv.record_lists;
    
    det_scores_div=getDetScorePred(div.record_lists);
    det_scores_ndiv=getDetScorePred(ndiv.record_lists);
    
    gap_record(i).gap=abs(det_scores_div-det_scores_ndiv);
    gap_record(i).div=det_scores_div;
    gap_record(i).ndiv=det_scores_ndiv;
end
matlabpool close;



ndiv=[gap_record(:).ndiv];
div=[gap_record(:).div];

[ndiv,idx_sort]=sort(ndiv);
div=div(idx_sort);

h=figure;
plot(1:numel(div),div,'-r');
hold on;
plot(1:numel(ndiv),ndiv,'-b');
legend('div','ndiv','location','NorthEastOutside');
out_file_name=fullfile(out_dir,['gap_record_' num2str(k) '.png']);
saveas(h,out_file_name);


out_file_name=fullfile(out_dir,['gap_record_' num2str(k) '.mat']);
save(out_file_name,'ndiv_path','div_path','gap_record');


end