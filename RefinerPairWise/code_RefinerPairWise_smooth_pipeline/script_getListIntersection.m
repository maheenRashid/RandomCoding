


folder_lists=['swapAllCombos_unique_10_' folder_type{folder_no} ...
    '_writeAndScoreLists_html'];
folder_lists=fullfile(dir_parent,folder_lists,'record_lists');
load(fullfile(dir_parent,folder,['record_box_info_all_unique_top_' ...
    num2str(n) '.mat']),'record_box_info_all');

out_dir=['swapAllCombos_unique_' num2str(n) '_' folder_type{folder_no} ...
    '_writeAndScoreLists_html'];
out_dir=fullfile(dir_parent,out_dir,'record_lists');
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end
matlabpool open
parfor mod_no=1:numel(record_box_info_all)
    id_curr=record_box_info_all(mod_no).id;
    list_file_curr=fullfile(folder_lists,[id_curr '.mat']);
    if ~exist(list_file_curr,'file')
        fprintf('does not exist %s\n',id_curr);
        continue;
    end
    list_curr=load(list_file_curr,'record_lists');
    lists=list_curr.record_lists.lists;
    scores=list_curr.record_lists.scores;
    mapping=record_box_info_all(mod_no).mapping-1;
    lists_bin=cellfun(@(x) ismember(x,mapping),lists,'UniformOutput',0);
    lists_bin=cellfun(@(x) sum(x)==numel(x),lists_bin);
    record_lists=list_curr.record_lists;
    record_lists.lists=lists(lists_bin);
    record_lists.scores=scores(lists_bin);
    out_file_name=fullfile(out_dir,[id_curr '.mat']);
    parsave(out_file_name,record_lists);
    
    
end
matlabpool close;


