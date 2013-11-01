ccc

% load (fullfile('..','swapModel_allBoxes_bestSortedByDPMScore_gt_withText_html','record_overlaps.mat'),'record_overlaps');
load (fullfile('..','swapModel_allBoxes_bestSortedByDPMScore_gt_withText_refine_html','record_overlaps.mat'),'record_overlaps');

load(fullfile('..','dpm_greater_-1_bbox_record_withDetections.mat'),'record');

record_copy=record;
im_list=unique(record(2,:));

for im_no=1:numel(im_list)
    bin=strcmp(im_list{im_no},record_copy(2,:));
    detections_curr=record_copy(:,bin);
    max_prev=0;
    for i=1:size(detections_curr,2)
        gt_nos=detections_curr{end,i};
        gt_nos(gt_nos~=0)=gt_nos(gt_nos~=0)+max_prev;
        max_temp=max(gt_nos);
        max_prev=max(max_temp,max_prev);
        detections_curr{end,i}=gt_nos;
    end
    
    record_copy(:,bin)=detections_curr;
%     keyboard;
end

record=record_copy;






str_labels={'bed','ns','ct','couch','chair'};
mapping=[1,8,9,2,4];

% create dpm bin

names_dpm_unique=unique(record(2,:));
temp=cell(size(names_dpm_unique));
record_dpm=struct('id',names_dpm_unique,'cat_no',temp,'bin',temp,'boxes',temp,'obj_map',temp);

for name_no=1:numel(names_dpm_unique)
    idx=find(strcmp(names_dpm_unique{name_no},record(2,:)));
    record_rel=record(:,idx);
    boxes_rel=record_rel(3,:);
    cat_labs_rel=record_rel(1,:);
    
    cat_nos=cell2mat(cellfun(@(x,y) mapping(strcmp(y,str_labels))*ones(size(x,1),1),boxes_rel,cat_labs_rel,'UniformOutput',0)');
    boxes_rel=cell2mat(boxes_rel');
    bin_rel=cell2mat(record_rel(4,:)');
    obj_map_rel=cell2mat(record_rel(5,:)');
    
    [sort_conf,sort_idx]=sort(boxes_rel(:,end),'descend');
   
    record_dpm(name_no).cat_no=cat_nos(sort_idx);
    if numel(bin_rel)>0
        record_dpm(name_no).bin=bin_rel(sort_idx);
        record_dpm(name_no).obj_map=obj_map_rel(sort_idx);
    end
    record_dpm(name_no).boxes=boxes_rel(sort_idx,:);
end


idx=~cellfun(@isempty,{record_dpm(:).bin});
record_dpm=record_dpm(idx);


% do a sanity check

for i=1:numel(record_dpm)
    names={record_overlaps(:).id};
    idx=find(~cellfun(@isempty,strfind(names,record_dpm(i).id)));
    if isempty(idx)
        continue;
    end
    if numel(idx)~=1
        keyboard;
    end
    
    rec_ov=record_overlaps(idx);
    matches_ov=rec_ov.match_data;
    for j=1:numel(matches_ov)
        dpm_idx_on_ground=matches_ov(j).dpm_idx_on_ground;
        dpm_cat=matches_ov(j).dpm_cat;
        dpm_idx_on_ground=dpm_idx_on_ground+1;
        
        cat_dpm=record_dpm(i).cat_no;
        cat_dpm_on_ground=cat_dpm(dpm_idx_on_ground);
        
        if ~isequal(dpm_cat',cat_dpm_on_ground)
            keyboard;
        end
        box_overlap=matches_ov(j).box_overlap;
        pixel_wise_overlaps=matches_ov(j).pixel_wise_overlaps;
        box_overlap_all=zeros(numel(cat_dpm),size(box_overlap,2));
        box_overlap_all(dpm_idx_on_ground,:)=box_overlap;        
        
        pixel_wise_overlaps_all=zeros(numel(cat_dpm),size(pixel_wise_overlaps,2));
        pixel_wise_overlaps_all(dpm_idx_on_ground,:)=pixel_wise_overlaps;
        
        matches_ov(j).box_overlap_all=box_overlap_all;
        matches_ov(j).pixel_wise_overlaps_all=pixel_wise_overlaps_all;
        matches_ov(j).bin_dpm_gt=record_dpm(i).bin;
        matches_ov(j).cat_dpm_gt=record_dpm(i).cat_no;
        matches_ov(j).obj_map_gt=record_dpm(i).obj_map;
    end
    record_overlaps(idx).match_data=matches_ov;

end

save (fullfile('..','swapModel_allBoxes_bestSortedByDPMScore_gt_withText_refine_html','record_overlaps_and_record_dpm.mat'),'record_overlaps','record_dpm');