ccc
% return
dir_parent='/lustre/maheenr/results_temp_09_13';
folders={'swapObjectsInBox_allOffsets_sizeComparison_bugFixed_gt_refPW',...
    'swapObjectsInBox_allOffsets_sizeComparison_bugFixed_refPW'};

folder_type={'gt','auto'};

n=3;

c_out_folder_pre=['swapAllCombos_unique_' num2str(n)];
c_out_folder_post={'_gt_writeFloorOverlap','_auto_writeFloorOverlap'};
c_file_to_run='writeFloorOverlap';


dir_parent='/lustre/maheenr/3dgp_results';
folders={'swap_in_box_auto_new_listsScores_1'};

for folder_no=1
%         :numel(folders)
    folder=folders{folder_no};
%     script_creatingDPMBinPerList;
%     fprintf('%s\n','creating feature vecs list');

    in_dir=[folder '_html'];
    script_getFeatureVecs_withCat;
%     fprintf('%s\n','saving test train data LOO');
%     script_saveTestTrainData_LOO_withCat;
    
%     k=nan(1);
%     fprintf('%s %d %s\n','getting ',k,' nearest neighbours');
%     script_nn_ratioEqual;
%     k_p_vec=0.01:0.01:0.1;
%    
%     fprintf('%s %d %s\n','getting kpvec nearest neighbours');
%     script_temp_checkingKNN;
%     fprintf('%s\n','getting dpm accu kpvec nearest neighbours');
%     script_saveDPMBinAccu_nn;
%     fprintf('%s\n','compiling dpm accu kpvec nearest neighbours');
%     script_compilingAccuracies;

%     fprintf('%s\n','getting linReg per model');
%     script_linReg_ratioEqual;
%     fprintf('%s\n','getting dpm accu linReg per model');
%     script_saveDPMBinAccu_linReg;
% 
% 
%     k_p_vec=0;
%     fprintf('%s\n','compiling dpm accu linReg');
%     script_compilingAccuracies;
%     dirs_str={'linReg_LOO'};

%     dirs_str=cellfun(@(x) [num2str(x) '_nn_LOO'],...
%         num2cell(k_p_vec),'UniformOutput',0);
%     dirs_str=[dirs_str 'linReg_LOO'];
%     script_writeBestLists;

% script_compilingAccuracies_diff;
end
