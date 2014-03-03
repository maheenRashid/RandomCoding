ccc

k_vec=[0.01:0.01:0.1,0.2:0.1:1];
str_struct='pr_c_struct.nn_dpm';
str_file='_curves_data.mat';

in_dir='prec_recall_knn_3_gt_by_prec_withCat';
[aps_wc,prec_wc,recall_wc]=getMatAccu(in_dir,k_vec,str_file,str_struct);

in_dir='prec_recall_knn_3_gt_by_prec_withCat_noOrder';
[aps_wc_no,prec_wc_no,recall_wc_no]=getMatAccu(in_dir,k_vec,str_file,str_struct);

figure; plot(k_vec,aps_wc,'-r'); hold on; plot(k_vec,aps_wc_no,'-g');
xlabel('percentage of neighbours');
ylabel('AP');
h=legend('conf_withCat','conf_withCat_noOrder');
set(h,'interpreter','none');
title('KNN');
figure; plot(mean(recall_wc,1),mean(prec_wc,1),'-r'); 
hold on; plot(mean(recall_wc_no,1),mean(prec_wc_no,1),'-g');
xlabel('Recall');
ylabel('Precision');
h=legend('conf_withCat','conf_withCat_noOrder');
set(h,'interpreter','none');
title('KNN');
dirs=dir(fullfile('prec_recall_curves*'));
dirs={dirs(:).name};
prec_recall_cells=cell(3,numel(dirs));
for i=1:numel(dirs)
    [ap,prec,recall]=getMatAccu(dirs{i},'','curves_data.mat',str_struct);
    prec_recall_cells{1,i}=ap;
    prec_recall_cells{2,i}=prec;
    prec_recall_cells{3,i}=recall;
end

figure; plot(cell2mat(prec_recall_cells(3,:)')',...
    cell2mat(prec_recall_cells(2,:)')');
leg_str=cellfun(@(x) strrep(x,'prec_recall_curves_mat_images_by_prec','conf')...
    ,dirs,'UniformOutput',0);

h=legend(leg_str);
set(h,'interpreter','none');
hold on;
gscatter(cell2mat(prec_recall_cells(1,:)),...
    cell2mat(prec_recall_cells(1,:)),1:numel(dirs),[],'o',[],'off');
grid on;
xlabel('Recall');
ylabel('Precision');
title('Lin Reg');

cell2mat(prec_recall_cells(1,:))



k_vec=[0.01:0.01:0.1,0.2:0.1:1];
str_struct='pr_c_struct.dpm';
str_file='_curves_data.mat';

in_dir='prec_recall_knn_3_gt_by_prec_withCat';
[aps_dpm,prec_dpm,recall_dpm]=getMatAccu(in_dir,k_vec,str_file,str_struct);
