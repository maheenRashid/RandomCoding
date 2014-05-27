ccc

cam_dir_meta='/lustre/maheenr/cube_per_cam_regenerate';
gt_dir='room3D_gt';
rendering_dir='swap_in_box';
in_dir=fullfile(cam_dir_meta,gt_dir,rendering_dir);

out_dir='record_box_info_all';
out_dir=fullfile(cam_dir_meta,gt_dir,out_dir);
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end

% names=dir(fullfile(in_dir));
% names={names(3:end).name};
addpath ..

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

% script_pruneAllBoxesInfo_Unique_individual

in_dir=out_dir;
out_dir=['best_swap_txt_' num2str(n)];

out_dir=['best_swap_txt_test_' num2str(n)];
out_dir=fullfile(cam_dir_meta,gt_dir,out_dir);
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end
names=dir(fullfile(in_dir,'*.mat'));
names={names(:).name};


% script_writeTextFiles_may_test;

out_dir_ac=['floorOverlap_test_' num2str(n)];
text_dir=out_dir;
out_dir=fullfile(cam_dir_meta,gt_dir,out_dir_ac);
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end

% script_writeCellCommands_floorOverlap_gt_may


%%%%NOW RUN THIS SHIT%%%%%

in_dir=out_dir;
out_dir=fullfile(cam_dir_meta,gt_dir,['list_files_noNeg_' num2str(n)]);
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end
names=dir(in_dir);
names={names(3:end).name};

x=load(fullfile(cam_dir_meta,gt_dir,'best_swap_overlap.mat'));
names=x.models;
names=cellfun(@(x) x(1:end-4),names,'UniformOutput',0);
[names_aft,idx_a,idx_b]=intersect(names,x.models_exclude);
names(idx_a)=[];
bin_info=x.bin_info;
bin_info(idx_a,:)=[];


fprintf('writing list files\n');
% script_writeListFiles_may;
% script_writeListFiles_noNeg_may_hack;

% return
out_dir_ac=['lists_scores_noNeg_' num2str(n)];
text_dirs={text_dir,out_dir};
out_dir=fullfile(cam_dir_meta,gt_dir,out_dir_ac);
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end

fprintf('writing list scores cellCommands\n');
script_writeCellCommands_scoreLists_gt_may

return
%%%%NOW RUN THIS SHIT%%%%%

folder_lists=fullfile(cam_dir_meta,gt_dir,'lists_scores_2');
folder_other=fullfile(cam_dir_meta,gt_dir,'floorOverlap_2');

% folder_lists=fullfile(cam_dir_meta,gt_dir,['lists_scores_noNeg_' num2str(1)]);
% folder_other=fullfile(cam_dir_meta,gt_dir,['floorOverlap_test_' num2str(n)]);

% dir_proc='processing_lists';
% dir_proc='processing_lists_no_neg_noprune';
dir_proc='processing_lists_noprune_noNeg_all_3';
out_dir=fullfile(cam_dir_meta,gt_dir,dir_proc,'record_lists');
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end
% names=dir(folder_lists);
% names=names(3:end);
% names={names(:).name};

script_parseListFiles_gt_may
% script_correctRecordLists_hack
% return
% path_record_lists=out_dir;
% load(fullfile(cam_dir_meta,gt_dir,'boxes_rec_all_new.mat'));
% load(fullfile(cam_dir_meta,gt_dir,'cubes_record_with3D.mat'));
% 
% script_fixUpIndices_gt_may


dir_lists=fullfile(cam_dir_meta,gt_dir,dir_proc,'record_lists');
% models=dir(fullfile(dir_lists,'*.mat'));
% models={models(:).name};
% script_fix_record_lists;
% 
% return

out_dir=fullfile(cam_dir_meta,gt_dir,dir_proc,'record_lists_dpm_bin');
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end
% models=dir(fullfile(dir_lists,'*.mat'));
% models={models(:).name};
load(fullfile(cam_dir_meta,gt_dir,'record_dpm_with_dets_room.mat'));

% script_creatingDPMBinPerList_gt_may

dir_dpm_bin=out_dir;
% models=dir(fullfile(dir_dpm_bin,'*.mat'));
% models={models(:).name};
out_dir=fullfile(cam_dir_meta,gt_dir,dir_proc,'record_lists_feature_vecs_withCat');
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end

% script_getFeatureVecs_withCat_gt_may
% return

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
else
    continue;
end
script_writeCellCommands_bestLists_gt_may
end