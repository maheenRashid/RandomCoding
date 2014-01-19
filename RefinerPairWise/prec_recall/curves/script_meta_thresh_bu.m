ccc

dir_parent='/lustre/maheenr/results_temp_09_13';
folders={'swapObjectsInBox_allOffsets_sizeComparison_bugFixed_gt_refPW',...
    'swapObjectsInBox_allOffsets_sizeComparison_bugFixed_refPW'};

folder_type={'gt','auto'};

n=3;


folder_no=1
folder=folders{folder_no};

in_dir=['swapAllCombos_unique_' num2str(n) '_' folder_type{folder_no} ...
    '_writeAndScoreLists_html'];

%create percentile strings and in out dirs
feature_dir=fullfile(dir_parent,in_dir,'record_lists_feature_vecs');

prctile_inc=0.1;
out_dir=fullfile(dir_parent,in_dir,'record_threshes_by_prec');
fprintf('%s\n','getting thresholds by prec');

script_getThresholds_temp;
