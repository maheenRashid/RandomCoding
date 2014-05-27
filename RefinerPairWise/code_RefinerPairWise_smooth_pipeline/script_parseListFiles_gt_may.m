% matlabpool open;
% par
for model_no=1:numel(names)
    
    id_curr=names{model_no};
    fprintf('model_no: %s %d\n',id_curr,model_no);
    
    out_file_name=fullfile(out_dir,[id_curr '.mat']);
    out_mutex=fullfile(out_dir,id_curr);
    if ~exist(out_mutex,'dir')
        mkdir(out_mutex);
    else
        continue;
    end
    
    try
        fname_lists=fullfile(folder_lists,id_curr,'scores_and_offsets.txt');
        fname_other=fullfile(folder_other,id_curr,'lists_and_scores.txt');
        record_lists=getOtherInfoFromFile(fname_other);
        [scores,lists,gt_scores]=getListInfoFromFile(fname_lists);
        record_lists.scores=scores;
        record_lists.lists=lists;
        record_lists.gt_scores=gt_scores;
        parsave(out_file_name,record_lists);
    catch err
        fprintf('error!\n');
        rmdir(out_mutex,'s');
    end
    
end
% matlabpool close




