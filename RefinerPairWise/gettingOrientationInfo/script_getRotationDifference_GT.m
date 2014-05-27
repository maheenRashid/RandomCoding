% ccc
% load(fullfile('orient_files','low_auto_us_2.mat'))
%     rot_diff_all={det_record(:).rot_diff};
%     rot_mat=cell2mat(rot_diff_all);
%     rot_mat(isinf(rot_mat))=[];
%     fprintf('percent 0 %d\n',sum(rot_mat==0)/numel(rot_mat))
%     fprintf('percent 180 %d\n',sum(rot_mat==180)/numel(rot_mat))
%     fprintf('percent 90 %d\n',sum(rot_mat==90)/numel(rot_mat))
% 
%     
% return
ccc

dir_parent_meta='/lustre/maheenr/cube_per_cam_regenerate';

dir_in=fullfile(dir_parent_meta,'room3D_gt');
dir_proc='processing_lists_noprune_noNeg_all';

best_lists=dir(fullfile(dir_in,dir_proc,'best_list_varying_by_prec_withCat_noOrder*'));
best_lists={best_lists(:).name};


dir_gt=fullfile(dir_parent_meta,'room3D_auto','gt_record');
load(fullfile(dir_gt,'record_gt_sun_with_orients.mat'),'record_gt');

ids_gt={record_gt(:).id};
thresh=0.5;
cat_no=2;
for list_no=[2,7]
    dir_rendering=best_lists{list_no};
    dir_masks=fullfile(dir_in,[dir_rendering '_html'],'record_masks');
    load(fullfile(dir_masks,['record_cat_pix_' num2str(cat_no) '.mat']),'det_record');
    [det_record(:).rot_diff]=deal([]);
    for i=1:numel(det_record)
        det_curr=det_record(i);
        [rot_diff]=getRotationDifference_gt(det_curr.det_overlap,...
            det_curr.orient_pred,det_curr.orient_gt,det_curr.quad,thresh);
        det_record(i).rot_diff=rot_diff;
    end
    rot_diff_all={det_record(:).rot_diff};
    rot_mat=cell2mat(rot_diff_all);
    rot_mat(isinf(rot_mat))=[];
    fprintf('percent 0 %d\n',sum(rot_mat==0)/numel(rot_mat))
    fprintf('percent 180 %d\n',sum(rot_mat==180)/numel(rot_mat))
        fprintf('percent 90 %d\n',sum(rot_mat==90)/numel(rot_mat))
%     save(fullfile(dir_masks,['record_cat_pix_' num2str(cat_no) '.mat']),'det_record');
end
