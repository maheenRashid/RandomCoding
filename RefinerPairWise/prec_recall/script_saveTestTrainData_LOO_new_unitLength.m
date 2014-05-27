
for fold_no=1:5
    fprintf('fold no %d\n',fold_no);
    
    out_mutex=fullfile(out_dir,[num2str(fold_no) '_unitLength']);
    out_file_name=fullfile(out_dir,num2str(fold_no),[num2str(fold_no) '_unitLength.mat']);
%     
    if ~exist(fullfile(out_dir,num2str(fold_no),[num2str(fold_no) '.mat']),'file')
        continue;
    end
    
    if ~exist(out_mutex,'dir')
        mkdir(out_mutex);
    else
        continue;
    end
    
    if exist(fullfile(out_dir,num2str(fold_no),[num2str(fold_no) '.mat']),'file')
        load(fullfile(out_dir,num2str(fold_no),[num2str(fold_no) '.mat']));
    else
       fprintf('continuing\n');
       continue;
    end
    
    feature_vecs_all=makeUnitLength(feature_vecs_all);
    out_file_name=fullfile(out_dir,num2str(fold_no),[num2str(fold_no) '_unitLength.mat']);
    save(out_file_name);
    
end

