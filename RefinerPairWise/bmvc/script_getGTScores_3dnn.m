ccc


dir_parent_meta='/lustre/maheenr/cube_per_cam_regenerate';
dir_in_cheat='/lustre/maheenr/results_temp_09_13/'

% dir_in=fullfile(dir_parent_meta,'room3D_auto');
% dir_proc='processing_lists_noprune_noNeg';
% dir_rendering_cheat='3dnn_auto';


dir_in=fullfile(dir_parent_meta,'room3D_gt');
dir_proc='processing_lists_noprune_noNeg_all';
dir_rendering_cheat='3dnn_gt';

dir_rendering='nn_render';
out_dir=fullfile(dir_in,[dir_rendering '_html'],'record_gt_scores');
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end

models=dir(fullfile(dir_in,dir_rendering));
models={models(3:end).name};

cat_mask_name='raw_cat_mask.png';
matlabpool open;
parfor model_no=1:numel(models)
    dir_curr=fullfile(dir_in_cheat,dir_rendering_cheat,models{model_no});
    im_cat_name=fullfile(dir_curr,'renderings',cat_mask_name);
    if ~exist(im_cat_name,'file')
        continue;
    end
    
    fname=fullfile(dir_curr,'scores_and_offsets.txt');
    fid=fopen(fname);
    data=textscan(fid,'%s','delimiter','\n');
    data=data{1};
    fclose(fid);
    
    data_rel=data{end};
    data_rel=regexpi(data_rel,' ','split');
    idx_match=find(strcmp('GT_SCORE_all_px',data_rel));
    strs=data_rel(idx_match:2:end);
    scores=data_rel(idx_match+1:2:end);
    scores=cellfun(@(x) str2num(x),scores);
    
    data_rel=data{end-2};
    data_rel=regexpi(data_rel,' ','split');
    idx_match=find(strcmp('GT_SCORE_all_px',data_rel));
    gt_scores=data_rel(idx_match+1:2:end);
    gt_scores=cellfun(@(x) str2num(x),gt_scores);
    
    record_scores=struct();
    record_scores.id=models{model_no};
    record_scores.pred_scores=scores;
    record_scores.gt_scores=gt_scores;
    record_scores.score_strs=strs;
    
    out_file_name=fullfile(out_dir,[models{model_no} '.mat']);
    parsave_name(out_file_name,record_scores,'record_scores');
end
matlabpool close;
