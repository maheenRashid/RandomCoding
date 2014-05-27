ccc


dir_parent_meta='/lustre/maheenr/cube_per_cam_regenerate';
% 
% dir_in=fullfile(dir_parent_meta,'room3D_auto');
% dir_proc='processing_lists_noprune_noNeg';
% out_dir='pix_overlap_auto';


dir_in=fullfile(dir_parent_meta,'room3D_gt');
dir_proc='processing_lists_noprune_noNeg_all';
out_dir='pix_overlap_gt';

best_lists=dir(fullfile(dir_in,dir_proc,'best_list_varying_by_prec_withCat_noOrder*'));
best_lists={best_lists(:).name};
best_lists=best_lists(1:7);

nn_dir='nn_render';
best_lists=[best_lists,nn_dir];

cat_nos=[1,2,4,8,9];
if ~exist(out_dir)
    mkdir(out_dir);
end


for cat_no=cat_nos


threshes=[0.5:0.01:1];
det_record_cell=cell(size(best_lists));
for dir_no=1:numel(best_lists)
    dir_rendering=best_lists{dir_no};    
    dir_masks=fullfile(dir_in,[dir_rendering '_html'],'record_masks');
    load(fullfile(dir_masks,['record_cat_' num2str(cat_no) '.mat']),'det_record');
    det_record_cell{dir_no}=det_record;
end

save(fullfile(out_dir,['dets_compiled_' num2str(cat_no) '.mat']),'det_record_cell','threshes','best_lists');
end

