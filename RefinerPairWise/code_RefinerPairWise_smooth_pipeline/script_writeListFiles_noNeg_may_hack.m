
for im_no=1:numel(names)
    fprintf('%d\n',im_no);
    mutex=fullfile(out_dir,names{im_no});
    if exist(mutex,'dir')
        continue
    else
        mkdir(mutex)
    end
    
    bin_curr=bin_info{im_no,2};
    
    [success,list_size,black_list]=...
        writingListFilesAfterReadingOverlap_hack(names{im_no},in_dir,out_dir,0.01,15*60,1,bin_curr);
    
%     if ~isempty(black_list)
%     fname=fullfile(out_dir_test,[names{im_no} '.txt']);
%     list=black_list-1;
%     lists={list,list};
%     writeLists(fname,lists,1,1);
%     end
%     
%         if success<1
%             rmdir(mutex,'s');
%         end
    
end