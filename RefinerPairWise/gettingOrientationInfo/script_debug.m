ccc

dir_parent_meta='/lustre/maheenr/cube_per_cam_regenerate';

% dir_in=fullfile(dir_parent_meta,'room3D_auto');
% dir_proc='processing_lists_noprune_noNeg';

dir_in=fullfile(dir_parent_meta,'room3D_gt');
% dir_proc='processing_lists_noprune_noNeg_all';

load(fullfile(dir_in,'lists_scores_2.mat'));
cellCommands{1}

return
ccc

% load('for_orient_debug');
load('record_cat_pix_1');
overlaps={det_record(:).det_overlap};
thresh=0.5;
overlaps=cellfun(@(x) x>thresh,overlaps,'UniformOutput',0);
overlaps=cellfun(@(x) sum(x)>0,overlaps);
det_rel=det_record(overlaps);
quads=[det_rel(:).quad];

transnum=4
for quad_no=4
    %     :4
    det_curr=det_rel(quads==quad_no);
    for model_no=1:numel(det_curr)
        if det_curr(model_no).transnum==transnum>0
            det_curr(model_no)
            keyboard;
        end
    end
end



return
ccc

load('for_use.mat');

map=rec_dpm.gt_skp_map;
gt_group=rec_gt.groups;
gt_rots=rec_gt.orients;
pred_rots=accu.rots;
quadrant=rec_gt.quad;
% [rot_diff]=getRotationDifference(map,gt_group,gt_rots,pred_rots,dpm_thresh,quadrant)
[rot_diff]=getRotationDifference(map,gt_group,gt_rots,pred_rots,accu.thresh_bin,quadrant);

% idx_val=find(map>0);
% map_rots=zeros(size(map));
% for i=1:numel(idx_val)
%     idx_val_curr=idx_val(i);
%     group_curr=map(idx_val_curr);
%     bin=gt_group==group_curr;
%     gt_rot_curr=gt_rots(bin);
%     map_rots(idx_val_curr)=gt_rot_curr;
% end

