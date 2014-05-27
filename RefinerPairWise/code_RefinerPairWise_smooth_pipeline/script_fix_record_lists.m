
matlabpool open;
parfor model_no=1:numel(models)
    record_lists=load(fullfile(dir_lists,models{model_no}));
    record_lists=record_lists.record_lists;
    
    [bin_neg]=getBinNeg(record_lists.box_nos,record_lists.box_dim);
    black_list=find(bin_neg);
    black_list=black_list-1;
    list_bin=cellfun(@(x) sum(ismember(x,black_list)),record_lists.lists);
    list_bin=list_bin>0;
    
    record_lists.lists(list_bin)=[];
    record_lists.scores(list_bin)=[];
    record_lists.gt_scores(list_bin,:)=[];
    
    parsave(fullfile(out_dir,models{model_no}),record_lists);
    
end
matlabpool close;