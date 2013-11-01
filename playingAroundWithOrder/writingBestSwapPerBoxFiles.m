ccc
dirs=dir(pwd);
dirs=dirs(3:end);

dir_strs={'swapObjectsInBox_allOffsets_sizeComparison_bugFixed_gt_html',...
    'best_swap_per_box_gt',...
    'swapObjectsInBox_allOffsets_sizeComparison_bugFixed_html',...
    'best_swap_per_box_auto'};

for dir_no=1:2:numel(dir_strs)
    load(fullfile(dir_strs{dir_no},'boxes_we_kept.mat'));
    
    out_dir=dir_strs{dir_no+1};
    if ~exist(out_dir,'dir')
        mkdir(out_dir)
    end
    
    record_cell=record_cell([1,6],:);
    for im_no=1:size(record_cell,2)
        if isempty(record_cell{1,im_no})
            continue
        end
        
        fid=fopen(fullfile(out_dir,[record_cell{end,im_no} '.txt']),'w');
        boxes=record_cell{1,im_no};
        fprintf(fid,'%d\n',size(boxes,1));
        for box_no=1:size(boxes,1)
            for val_no=1:size(boxes,2)
                fprintf(fid,'%d\n',boxes(box_no,val_no));
            end
            fprintf(fid,'%s\n','C');
        end
        fclose(fid);
    end
end