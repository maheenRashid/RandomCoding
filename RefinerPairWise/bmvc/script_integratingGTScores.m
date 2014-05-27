ccc

dir_parent_meta='/lustre/maheenr/cube_per_cam_regenerate';

% dir_in_cam='room3D_auto';
% dir_proc='processing_lists_noprune_noNeg';

dir_in_cam='room3D_gt';
dir_proc='processing_lists_noprune_noNeg_all';

dir_in=fullfile(dir_parent_meta,dir_in_cam);

best_lists=dir(fullfile(dir_in,dir_proc,...
    'best_list_varying_by_prec_withCat_noOrder*'));
best_lists={best_lists(:).name};
best_lists=[best_lists 'nn_render'];

out_dir_fs=fullfile('gt_scores',dir_in_cam);
if ~exist(out_dir_fs,'dir')
    mkdir(out_dir_fs)
end

for list_no=[1:7,numel(best_lists)]
    fprintf('list no %d\n',list_no);
    %     numel(best_lists)
    dir_rendering=best_lists{list_no};
    in_dir=fullfile(dir_in,[dir_rendering '_html'],'record_gt_scores');
    
    models=dir(fullfile(in_dir,'*sun*.mat'));
    models={models(:).name};
    dummy=cell(size(models));
    record_scores=struct('id',dummy,'pred_scores',dummy,'gt_scores',dummy,'score_strs',dummy);
%     matlabpool open;
%     par
    for model_no=1:numel(models)
        x=load(fullfile(in_dir,models{model_no}));
        record_scores(model_no)=x.record_scores;
    end
%     matlabpool close;
    
    out_file_name=fullfile(in_dir,'record_gt_scores_integrated.mat');
    save(out_file_name,'record_scores')
    
    out_file_name_us=fullfile(out_dir_fs,[dir_rendering '.mat']);
    save(out_file_name_us,'record_scores');
    
end

