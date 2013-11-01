ccc
dirs=dir(pwd);
dirs=dirs(3:end);

parent_dir='../testingAccuracyBugForNewExperiments';
 a=dir(fullfile(parent_dir,'swapObjectsInBox*'));
 a=a(1:4);
%  ;a=a(7:10);
 
 
 
 
 
%  return
 
for dir_no=1:numel(a)
    load(fullfile(parent_dir,a(dir_no).name,'boxes_kept_detail.mat'));
    
    out_dir=a(dir_no).name;
    out_dir=out_dir(1:end-5);
%     keyboard;
    if ~exist(out_dir,'dir')
        mkdir(out_dir)
    end
    
    record_cell=boxes_ids;
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