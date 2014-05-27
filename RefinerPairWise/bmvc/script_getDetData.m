ccc

dir_parent_meta='/lustre/maheenr/cube_per_cam_regenerate';

dir_in_cam='room3D_auto';
dir_proc='processing_lists_noprune_noNeg';
% 
% dir_in_cam='room3D_gt';
% dir_proc='processing_lists_noprune_noNeg_all';

dir_in=fullfile(dir_parent_meta,dir_in_cam);

best_lists=dir(fullfile(dir_in,dir_proc,...
    'prec_recall_curves_mat_images*'));
best_lists={best_lists(:).name};


out_dir='prec_recall_auto';
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end
for i=1:numel(best_lists)
    file=fullfile(dir_in,dir_proc,best_lists{i},'curves_data.mat');
    copyfile(file,fullfile(out_dir,[best_lists{i} '.mat']));
end

