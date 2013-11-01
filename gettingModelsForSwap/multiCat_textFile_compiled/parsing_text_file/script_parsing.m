


out_dir=[dir_all_boxes '_html'];
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end
models=dir(dir_all_boxes);
models=models(3:end);

record_overlaps_etc=struct();
record_overlaps_etc(numel(models)).id='';
matlabpool open
parfor i=1:numel(models)
    record_overlaps(i).id=models(i).name;
    
    box_no=dir(fullfile(dir_all_boxes,models(i).name));
    box_no=box_no(3:end);
    
    record_inner=struct();
    record_inner(numel(box_no)).box_no='';
    for j=1:numel(box_no);
        match=dir(fullfile(dir_all_boxes,models(i).name,box_no(j).name));
        match=match(3:end);
        if numel(match)~=1
            keyboard;
        end
        fid=fopen(fullfile(dir_all_boxes,models(i).name,box_no(j).name,match(1).name,'overlaps.txt'));
        data=textscan(fid,'%s','delimiter','\n');
        data=data{1};
        fclose(fid);
        
        [numbers,strs]=getFileData(data);
        
        record_inner(j).box_no=box_no(j).name;
        record_inner(j).match_id=match(1).name;
        record_inner(j).numbers=numbers;
        record_inner(j).strs=strs;
    end
    record_overlaps(i).match_data=record_inner;

end
matlabpool close
save(fullfile(out_dir,'record_overlaps.mat'),'record_overlaps');