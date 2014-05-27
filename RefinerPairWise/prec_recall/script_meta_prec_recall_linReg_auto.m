ccc


dir_parent_org='/lustre/maheenr/3dgp_results';

dir_parent='/lustre/maheenr/cube_per_cam_regenerate/room3D_auto';
folder='swap_in_box_auto_listsScores_1';
rec_path='/lustre/maheenr/cube_per_cam_regenerate/room3D_auto';

feature_pre='record_lists_feature_vecs_withCat';
prctile_pre='by_prec_withCat_noOrder';
prctile_temp='by_prec_withCat';
prctile_inc=0.1;

% in_dir='processing_lists_noprune_noNeg';
in_dir='processing_lists_noprune_noNeg_3';
in_dir_cheat=in_dir;

%create percentile strings and in out dirs
feature_dir=fullfile(dir_parent,in_dir,feature_pre);

out_dir=fullfile(dir_parent,in_dir,'record_threshes_by_prec');
fprintf('%s\n','getting thresholds by prec');

load (fullfile(rec_path,'record_dpm_with_dets_room.mat'));

out_dir_cheat=fullfile(dir_parent_org,'swap_in_box_auto_listsScores_1_html','record_threshes_by_prec');

load(fullfile(out_dir_cheat,'record_threshes.mat'),'record_threshes');
prctile_vec=record_threshes.prct_vec;
threshes=record_threshes.threshes_aft;

prctile_str=cellfun(@num2str,num2cell(prctile_vec),'UniformOutput',0);
temp=prctile_str;
prctile_str=cellfun(@(x) [prctile_pre '_' x],prctile_str,'UniformOutput',0);
prctile_str_temp=cellfun(@(x) [prctile_temp '_' x],temp,'UniformOutput',0);

fprintf('%s\n','getting thresholded feature vecs');
% script_getThresholdedFeatureVecs;
% return
error_log=cell(1,0);
compiled_dirs=cell(1,numel(prctile_str));
%loop over each percentiles features
for feature_no=[2,7]
%     numel(prctile_str)
    
    fprintf('%s\n',...
        ['save whitened training data ' ...
        prctile_str{feature_no} ' percentile']);
    dir_feature_vec=fullfile(dir_parent,in_dir_cheat,...
        [feature_pre '_' prctile_str{feature_no}]);
    
    out_dir=fullfile(dir_parent,in_dir,...
        ['testTrainData_LOO_varyingRatio_' prctile_str{feature_no}]);

    out_dir_old=out_dir;

%     script_saveTestTrainData_LOO_new_byFold;
%     script_saveTestTrainData_LOO_new_unitLength;
%     script_saveTestTrainData_LOO_new_byFold_debug_ratio;
         
%     script_saveTestTrainData_whitened_individual_new_test;
%     script_saveTestTrainData_whitened_individual_varyingRatio;
    
    fprintf('%s\n',...
        ['do linReg ' prctile_str{feature_no} ' percentile']);
    dir_nn_loo=out_dir;
    out_dir=fullfile(dir_parent,in_dir,...
        ['results_linReg_LOO_varyingRatio_' prctile_str{feature_no}]);
%     script_linReg_ratioEqual_prec_recall;
% 
    fprintf('%s\n',...
        ['get dpm accu ' prctile_str{feature_no} ' percentile']);
    dir_result=out_dir;
    out_dir=fullfile(dir_parent,in_dir,...
        ['dpm_accu_per_mod_linReg_varyingRatio_' prctile_str{feature_no}]);
%     script_saveDPMAccu_prec_recall;
    
    fprintf('%s\n',...
        ['compile prec recall ' prctile_str{feature_no} ' percentile']);
    dir_dpm_accu=out_dir;
    out_dir=fullfile(dir_parent,in_dir,...
        ['dpm_accu_compiled_linReg_varyingRatio_' prctile_str{feature_no}]);
%     script_compileDPMAccu_prec_recall;
    
    compiled_dirs{feature_no}=out_dir;
    
end
compiled_dirs=compiled_dirs([2,7]);
out_dir=fullfile(dir_parent,in_dir,...
    ['prec_recall_curves_mat_images_varyingRatio_' prctile_pre]);
script_savePrecRecallCompiledMatAndImages;


