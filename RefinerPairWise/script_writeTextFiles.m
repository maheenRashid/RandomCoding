ccc
return

% dir_parent='/lustre/maheenr/results_temp_09_13';
dir_parent='';
folders={'swapObjectsInBox_allOffsets_sizeComparison_bugFixed_gt_refPW','swapObjectsInBox_allOffsets_sizeComparison_bugFixed_refPW'};



for folder_no=1:numel(folders)
    folder=folders{folder_no};
    load(fullfile(dir_parent,folder,'record_box_info_all_unique_top_10.mat'),'record_box_info_all');
    out_dir=fullfile(dir_parent,folder,'text_files');
    
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
        
end
