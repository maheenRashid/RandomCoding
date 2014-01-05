% text_files=cell(size(folders));

    folder=folders{folder_no};
    load(fullfile(dir_parent,folder,['record_box_info_all_unique_top_' num2str(n) '.mat']),'record_box_info_all');
    out_dir=fullfile(dir_parent,folder,['text_files_' num2str(n)]);

    if ~exist(out_dir,'dir')
        mkdir(out_dir);
    end
    
    matlabpool open;
    parfor i=1:numel(record_box_info_all)
        
        filename=fullfile(out_dir,[record_box_info_all(i).id '.txt']);
        disp(num2str(i))
        writeTopNFileFromStruct(filename,record_box_info_all(i));
        
    end
    matlabpool close;
    
    text_file_path=out_dir;
        
% end
