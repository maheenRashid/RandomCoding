ccc

n=3;
folder_type={'gt','auto'};
folder_no=1;

in_dir=['swapAllCombos_unique_' num2str(n) '_' folder_type{folder_no} ...
    '_writeAndScoreLists_html'];
dir_in_meta=fullfile(dir_parent,in_dir);
prctile_pre='by_prec_withCat_noOrder';
prctile_str={'0.10109'};
prctile_str=cellfun(@(x) [prctile_pre '_' x],prctile_str,'UniformOutput',0);
dir_lists=fullfile(dir_in_meta,...
    ['testTrainData_LOO_ratioEqual_' prctile_str{feature_no}]);

feature_no=1;

for k=0.1:0.1:1;

dir_in_k=fullfile(dir_in_meta,['KNN_' num2str(k) '_LOO_ratioEqual']);
dir_results=fullfile(dir_in_k,...
    ['results_' prctile_str{feature_no}]);

out_dir=fullfile(dir_in_k,'best_list_text');

    script_writeBestListText;

end
