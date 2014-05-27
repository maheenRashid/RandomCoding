ccc

cam_dir_meta='/lustre/maheenr/cube_per_cam_regenerate';
cams=dir(fullfile(cam_dir_meta,'room3D*'));
cams={cams(:).name};

load(fullfile(cam_dir_meta,cams{end},'record_dpm_with_dets_room.mat'),...
    'record_dpm');

gt_dir=fullfile(cam_dir_meta,cams{end},'gt_record');
load(fullfile(gt_dir,'record_gt.mat'),'record_gt');

thresh=0.35;
ids_gt={record_gt(:).id};
ids_gt=cellfun(@(x) regexpi(x,'#','split'),ids_gt,'UniformOutput',0);
ids_gt=cellfun(@(x) x{end},ids_gt,'uniformOutput',0);
error_log=cell(1,0);
for i=1:numel(record_dpm)
    fprintf('%d\n',i);
    id=record_dpm(i).id;
    idx=find(strcmp(id,ids_gt));
    rec_gt=record_gt(idx);
    
    cat_gt=rec_gt.cats;
    group_gt=rec_gt.groups;
    
    bin=record_dpm(i).bin;
    bin=bin>0;
    cats_dpm=record_dpm(i).cat_no;
    cats_dpm=cats_dpm(bin);
    boxes_dpm=record_dpm(i).boxes;
    boxes_dpm=boxes_dpm(bin,1:4);
    
    mapping=zeros(size(cats_dpm));
    
    for cat_no=1:numel(cats_dpm)
        cat_idx=cat_gt==cats_dpm(cat_no);
        if sum(cat_idx)<1
            fprintf('continuing 1\n');
            error_log=[error_log id];
            continue;
        end
        boxes_pred=boxes_dpm(cat_no,:);
        boxes_gt=cell2mat(rec_gt.boxes(cat_idx));
        os = getosmatrix_bb(boxes_pred,boxes_gt);
        bin_val=os>=thresh;
        if sum(bin_val)<1
            fprintf('continuing 2\n');
            error_log=[error_log id];
            continue;
        elseif sum(bin_val)>1
            [~,max_idx]=max(os,[],2);
        else
            max_idx=find(bin_val);
        end
        
        temp=find(cat_idx);
        temp=temp(max_idx);
        group_idx=group_gt(temp);
        mapping(cat_no)=group_idx;
    end
    
    mapping_big=zeros(size(record_dpm(i).cat_no));
    mapping_big(bin)=mapping;
    
    record_dpm(i).gt_skp_map=mapping_big;
end

save(fullfile(gt_dir,'record_dpm_with_map.mat'),'record_dpm','error_log');