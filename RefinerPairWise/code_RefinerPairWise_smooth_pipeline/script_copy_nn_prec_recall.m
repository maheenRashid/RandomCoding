ccc

dir_parent='/lustre/maheenr/results_temp_09_13';
in_dir=['swapAllCombos_unique_3_gt_writeAndScoreLists_html'];
dir_in_meta=fullfile(dir_parent,in_dir);

out_dir='prec_recall_knn_3_gt';

if ~exist(out_dir,'dir')
    mkdir(out_dir)
end

k_vec=[0.01:0.01:0.1,0.2:0.1:1];
for k_no=k_vec

    dir_in_k=fullfile(dir_in_meta,['KNN_' num2str(k_no) '_LOO_ratioEqual']);
    dir_in_prec=fullfile(dir_in_k,...
    'prec_recall_curves_mat_images_by_prec_withCat_noOrder');

    source_file=fullfile(dir_in_prec,'curves_data.mat');
    dest_file=fullfile(out_dir,[num2str(k_no) '_curves_data.mat']);
    copyfile(source_file,dest_file);
end

