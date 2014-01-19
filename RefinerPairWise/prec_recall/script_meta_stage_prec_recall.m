ccc

dir_parent='/lustre/maheenr/results_temp_09_13';
folders={'swapObjectsInBox_allOffsets_sizeComparison_bugFixed_gt_refPW',...
    'swapObjectsInBox_allOffsets_sizeComparison_bugFixed_refPW'};

folder_type={'gt','auto'};

n=3;

c_out_folder_pre=['swapAllCombos_unique_' num2str(n)];
c_out_folder_post={'_gt_writeFloorOverlap','_auto_writeFloorOverlap'};
c_file_to_run='writeFloorOverlap';

for folder_no=1
    %         :numel(folders)
    folder=folders{folder_no};
    
    in_dir=['swapAllCombos_unique_' num2str(n) '_' folder_type{folder_no} ...
        '_writeAndScoreLists_html'];
    
    %create percentile strings and in out dirs
    feature_dir=fullfile(dir_parent,in_dir,'record_lists_feature_vecs');
    
    prctile_inc=0.1;
    out_dir=fullfile(dir_parent,in_dir,'record_threshes_by_prec');
    fprintf('%s\n','getting thresholds by prec');
%     script_getThresholds;
%     return
    load(fullfile(out_dir,'record_threshes.mat'),'record_threshes');
    prctile_vec=record_threshes.prct_vec;
    threshes=record_threshes.threshes_aft;
    
%     prctile_vec=prct_vec;
    prctile_str=cellfun(@num2str,num2cell(prctile_vec),'UniformOutput',0);
    prctile_str=cellfun(@(x) ['by_prec_' x],prctile_str,'UniformOutput',0);
    
    fprintf('%s\n','getting thresholded feature vecs');
    script_getThresholdedFeatureVecs;
    
    compiled_dirs=cell(1,numel(prctile_str));
    %loop over each percentiles features
    for feature_no=1:numel(prctile_str)
        fprintf('%s\n',...
            ['save whitened training data ' ...
            prctile_str{feature_no} ' percentile']);
        dir_feature_vec=fullfile(dir_parent,in_dir,...
            ['record_lists_feature_vecs_' prctile_str{feature_no}]);
        out_dir=fullfile(dir_parent,in_dir,...
            ['testTrainData_LOO_ratioEqual_' prctile_str{feature_no}]);
                script_saveTestTrainData_LOO_new;
        
        
        fprintf('%s\n',...
            ['do linReg ' prctile_str{feature_no} ' percentile']);
        dir_nn_loo=out_dir;
        out_dir=fullfile(dir_parent,in_dir,...
            ['results_linReg_LOO_ratioEqual_' prctile_str{feature_no}]);
                script_linReg_ratioEqual_prec_recall;
        
        fprintf('%s\n',...
            ['get dpm accu ' prctile_str{feature_no} ' percentile']);
        dir_result=out_dir;
        out_dir=fullfile(dir_parent,in_dir,...
            ['dpm_accu_per_mod_linReg_' prctile_str{feature_no}]);
                script_saveDPMAccu_prec_recall;
                
        fprintf('%s\n',...
            ['compile prec recall ' prctile_str{feature_no} ' percentile']);
        dir_dpm_accu=out_dir;
        out_dir=fullfile(dir_parent,in_dir,...
            ['dpm_accu_compiled_linReg_' prctile_str{feature_no}]);
                script_compileDPMAccu_prec_recall;
        compiled_dirs{feature_no}=out_dir;
    end
    
    fprintf('%s\n','create prec recall curves');
    out_dir=fullfile(dir_parent,in_dir,...
        'prec_recall_curves_mat_images_by_prec');
    script_savePrecRecallCompiledMatAndImages;
    
end
