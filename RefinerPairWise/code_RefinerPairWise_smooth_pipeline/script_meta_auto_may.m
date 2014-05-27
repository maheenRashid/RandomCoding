ccc

cam_dir_meta='/lustre/maheenr/cube_per_cam_regenerate';
gt_dir='room3D_auto';
rendering_dir='swap_in_box';
in_dir=fullfile(cam_dir_meta,gt_dir,rendering_dir);

out_dir='record_box_info_all';
out_dir=fullfile(cam_dir_meta,gt_dir,out_dir);
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end
% 
% names=dir(fullfile(in_dir));
% names={names(3:end).name};
addpath ..
% 
% fprintf('getting box info\n');
% script_getAllBoxesInfo_individual;

% n=1;
n=3;
in_dir=out_dir;
out_dir=['record_box_info_top_' num2str(n)];
out_dir=fullfile(cam_dir_meta,gt_dir,out_dir);
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end
% names=dir(fullfile(in_dir,'*.mat'));
% names={names(:).name};

% fprintf('pruning box info\n');
% script_pruneAllBoxesInfo_Unique_individual

in_dir=out_dir;
out_dir=['best_swap_txt_noprune_' num2str(n)];
out_dir=fullfile(cam_dir_meta,gt_dir,out_dir);
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end
% names=dir(fullfile(in_dir,'*.mat'));
% names={names(:).name};

% fprintf('writing best swap files\n');
% script_writeTextFiles_may_test;

out_dir_ac=['floorOverlap_noprune_' num2str(n)];
text_dir=out_dir;
out_dir=fullfile(cam_dir_meta,gt_dir,out_dir_ac);
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end

% fprintf('writing cellcommands floor overlap\n');
% script_writeCellCommands_floorOverlap_auto_may


%%%%NOW RUN THIS SHIT%%%%%

in_dir=out_dir;
out_dir=fullfile(cam_dir_meta,gt_dir,['list_files_noNeg_' num2str(n)]);
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end
% names=dir(in_dir);
% names={names(3:end).name};


out_dir_test=fullfile(cam_dir_meta,gt_dir,['list_files_negTest_' num2str(n)]);
if ~exist(out_dir_test,'dir')
    mkdir(out_dir_test);
end

% fprintf('writing list files\n');
% script_writeListFiles_noNeg_may;

out_dir_ac=['lists_scores_noNeg_' num2str(n)];
text_dirs={text_dir,out_dir};
out_dir=fullfile(cam_dir_meta,gt_dir,out_dir_ac);
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end

% fprintf('writing list scores cellCommands\n');
% script_writeCellCommands_scoreLists_auto_may
% 

%%%%NOW RUN THIS SHIT%%%%%

folder_lists=fullfile(cam_dir_meta,gt_dir,out_dir_ac);
folder_other=fullfile(cam_dir_meta,gt_dir,['floorOverlap_noprune_' num2str(n)]);
dir_proc='processing_lists_noprune_noNeg_3';
out_dir=fullfile(cam_dir_meta,gt_dir,dir_proc,'record_lists');
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end
% names=dir(folder_lists);
% names=names(3:end);
% names={names(:).name};

% script_parseListFiles_gt_may


% path_record_lists=out_dir;
% load(fullfile(cam_dir_meta,gt_dir,'boxes_rec_all_new.mat'));
% load(fullfile(cam_dir_meta,gt_dir,'cubes_record_with3D.mat'));
% 
% script_fixUpIndices_gt_may


dir_lists=fullfile(cam_dir_meta,gt_dir,dir_proc,'record_lists');
% models=dir(fullfile(dir_lists,'*.mat'));
% models={models(:).name};

% script_fix_record_lists;


out_dir=fullfile(cam_dir_meta,gt_dir,dir_proc,'record_lists_dpm_bin');
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end
% models=dir(fullfile(dir_lists,'*.mat'));
% models={models(:).name};
% load(fullfile(cam_dir_meta,gt_dir,'record_dpm_with_dets_room.mat'));
% 
% script_creatingDPMBinPerList_gt_may
% 
% return
dir_dpm_bin=out_dir;
models=dir(fullfile(dir_dpm_bin,'*.mat'));
models={models(:).name};
out_dir=fullfile(cam_dir_meta,gt_dir,dir_proc,'record_lists_feature_vecs_withCat');
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end

script_getFeatureVecs_withCat_gt_may

return
%%%%%%NOW RUN script_meta_prec_recall_linReg_withCat_new %%%%%


best_lists=dir(fullfile(cam_dir_meta,gt_dir,dir_proc,'best_list_varying_by_prec_withCat_noOrder*'));
best_lists={best_lists(:).name};

for i=1:numel(best_lists)
    fprintf('%d\n',i);
out_dir_ac=best_lists{i};
path_to_best_list=fullfile(cam_dir_meta,gt_dir,dir_proc,best_lists{i});
text_dirs={text_dirs{1} path_to_best_list};
out_dir=fullfile(cam_dir_meta,gt_dir,out_dir_ac);
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end
script_writeCellCommands_bestLists_auto_may
end

