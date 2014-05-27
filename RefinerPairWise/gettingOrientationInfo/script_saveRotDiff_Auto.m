ccc


dir_parent_meta='/lustre/maheenr/cube_per_cam_regenerate';

dir_in=fullfile(dir_parent_meta,'room3D_auto');
dir_proc='processing_lists_noprune_noNeg';
in_mat_pre='record_cat_pix_';
% in_mat_pre='record_cat_box_';

best_lists=dir(fullfile(dir_in,dir_proc,'best_list_varying_by_prec_withCat_noOrder*'));
best_lists={best_lists(:).name};

cat_types=[1,2,4,8,9];
thresh=0.5;
for list_no=1:7
%     numel(best_lists)
    fprintf('%d of %d\n',list_no,numel(best_lists));
    dir_rendering=best_lists{list_no};
    dir_masks=fullfile(dir_in,[dir_rendering '_html'],'record_masks');
    for cat_no=1
        in_mat=[in_mat_pre num2str(cat_no) '.mat'];
        load(fullfile(dir_masks,in_mat),'det_record');
        [det_record(:).rot_diff]=deal([]);
        for i=1:numel(det_record)
            det_curr=det_record(i);
            [rot_diff]=getRotDiff_Box_Auto(det_curr.det_overlap,...
                det_curr.orient_pred,det_curr.orient_gt,det_curr.quad,thresh);
            det_record(i).rot_diff=rot_diff;
        end
        rot_diff_all={det_record(:).rot_diff};
        rot_mat=cell2mat(rot_diff_all);
        rot_mat(isinf(rot_mat))=[];
        fprintf('percent 0 %d\n',sum(rot_mat==0)/numel(rot_mat))
        fprintf('percent 180 %d\n',sum(rot_mat==180)/numel(rot_mat))
        
        save(fullfile(dir_masks,in_mat),'det_record');
    end
end
