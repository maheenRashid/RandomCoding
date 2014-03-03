ccc

load('lets_analyze_question.mat','cell_div');
cell_div=cell2mat(cell_div');
figure; imagesc(cell_div);

return
ccc

dir_parent='/lustre/maheenr/results_temp_09_13';
in_dir='diversity_question';
dir_in_meta=fullfile(dir_parent,in_dir);
prctile_pre='by_prec_withCat';

prctile_vec=0.10109;
prctile_str=cellfun(@num2str,num2cell(prctile_vec),'UniformOutput',0);
prctile_str=cellfun(@(x) [prctile_pre '_' x],prctile_str,'UniformOutput',0);

div_prct_vec=[0.05,0.5,1];
div_prct_str=cellfun(@num2str,num2cell(div_prct_vec),'UniformOutput',0);

prctile_str=cellfun(@(x) [prctile_str{1} '_diversity_' x],div_prct_str,...
    'UniformOutput',0);
k=nan;

dir_in_k=fullfile(dir_in_meta,['KNN_' num2str(k) '_LOO_ratioEqual']);

feature_no=1;
res_dir=fullfile(dir_in_k,...
    ['results_' prctile_str{feature_no}]);
models=dir(fullfile(res_dir,'*.mat'));

cell_div=cell(numel(models),1);
for i=1:numel(models)
    models(i).name
    m=load(fullfile(res_dir,models(i).name));
    cell_div{i}=m.record_lists.idx_div;
end

save('lets_analyze_question.mat','cell_div');