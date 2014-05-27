ccc

% mat_name='3dnn_gt_1.mat';

% mat_name='3dnn_gt_2.mat';
% mat_name=fullfile('orient_files','low_auto_us_2.mat');
mat_name=fullfile('orient_files','high_auto_us_2.mat');
load(mat_name);

% in_dir_pre='http://warp.hpc1.cs.cmu.edu:8000/cube_per_cam_regenerate/room3D_auto/nn_render';
% in_dir_pre='http://warp.hpc1.cs.cmu.edu:8000/cube_per_cam_regenerate/room3D_gt/nn_render';
% in_dir_pre='http://warp.hpc1.cs.cmu.edu:8000/cube_per_cam_regenerate/room3D_auto/best_list_varying_by_prec_withCat_noOrder_0.14976';
in_dir_pre='http://warp.hpc1.cs.cmu.edu:8000/cube_per_cam_regenerate/room3D_auto/best_list_varying_by_prec_withCat_noOrder_0.39976';
% post_normal='renderings/after_match_normal.png';
% post_overlay='renderings/after_match_overlay.png';
post_normal='renderings/list_best_pred_normal.png';
post_overlay='renderings/list_best_pred_overlay.png';

thresh=0.5;
[det_record(:).rot_diff]=deal([]);
for i=1:numel(det_record)
    det_curr=det_record(i);
    [rot_diff]=getRotDiff_NN_manual(det_curr,thresh,in_dir_pre,post_normal,post_overlay);
    det_record(i).rot_diff=rot_diff;
end

save(mat_name,'det_record');

% best_list_varying_by_prec_withCat_noOrder_0.14976
% best_list_varying_by_prec_withCat_noOrder_0.39976