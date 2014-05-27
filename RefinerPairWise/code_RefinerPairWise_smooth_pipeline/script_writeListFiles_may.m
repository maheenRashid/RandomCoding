
for im_no=1:numel(names)
    fprintf('%d\n',im_no);
    mutex=fullfile(out_dir,names{im_no});
    if exist(mutex,'dir')
        continue
    else
        mkdir(mutex)
    end
    
    [success]=writingListFilesAfterReadingOverlap(names{im_no},in_dir,out_dir);
    
%     if success<1
%         rmdir(mutex,'s');
%     end

end