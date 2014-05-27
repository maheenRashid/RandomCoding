function record_gt=getGTStruct(id,rendering_dir,cat_dir,groups_dir,orient_dir)
    
    record_gt.id=id;

    file=fullfile(rendering_dir,id,'scores_and_offsets.txt');
    fid=fopen(file);
    data=textscan(fid,'%s','delimiter','\n');
    data=data{1};
    data=data{2};
    quad=str2num(data(end));
    record_gt.quad=quad;
    
    cat_file=fullfile(cat_dir,[id '.txt']);
    record_gt.cats=readInVec(cat_file);
    
    
    orient_file=fullfile(orient_dir,[id '.txt']);
    record_gt.orients=readInVec(orient_file);
    
    group_file=fullfile(groups_dir,[id '.txt']);
    record_gt.groups=readInVec(group_file);
    
    im_file=fullfile(rendering_dir,id,'renderings','raw_object_mask.png');
    [record_gt.boxes]=getBox(im_file,record_gt.groups);
end

function vec=readInVec(filename)
    fid=fopen(filename);
    vec=textscan(fid,'%s','delimiter','\n');
    vec=vec{1};
    vec=cellfun(@str2num,vec);

end


function[boxes]=getBox(im_file,groups)

    boxes=cell(size(groups));
    im=imread(im_file);
    for i=1:numel(groups)
        mask=im==groups(i);
        [x,y]=find(mask);
        box_curr=[min(y) min(x) max(y) max(x)];
        boxes{i}=box_curr;
    end

end