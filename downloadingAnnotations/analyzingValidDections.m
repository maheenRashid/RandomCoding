ccc
load('dpm_greater_-1_bbox_record_withDetections.mat');
record_copy=record;
im_list=unique(record(2,:),'stable');

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
% return
% 
% 
% ccc
% load('dpm_greater_-1_bbox_record_withDetections.mat');
% im_list=unique(record(2,:),'stable');

% load (fullfile('swapObjectsInBox_allOffsets_sizeComparison_bugFixed_html','boxes_on_ground.mat'));
% load(fullfile('swapObjectsInBox_allOffsets_sizeComparison_bugFixed_html','boxes_we_kept.mat'));


load (fullfile('swapObjectsInBox_allOffsets_sizeComparison_bugFixed_gt_html','boxes_on_ground.mat'));
load(fullfile('swapObjectsInBox_allOffsets_sizeComparison_bugFixed_gt_html','boxes_we_kept_cell.mat'));


bin_empty=cellfun(@isempty,record_cell(end,:));
record_cell(:,bin_empty)=[];

accuracy_cell=cell(3,numel(im_list));
for im_no=1:numel(im_list)
    detections_curr=strcmp(im_list{im_no},record(2,:));
    detections_curr=record(:,detections_curr);
    
    if numel(detections_curr{4,1})==0
        continue
    end
    
    % order detections
    boxes=detections_curr(3,:);
    boxes=boxes';
    boxes=cell2mat(boxes);
    boxes=boxes(:,end);
    [~,idx_box]=sort(boxes,'descend');
    bin_dpm_curr=cell2mat(detections_curr(4,:)');
    bin_dpm_obj_map=cell2mat(detections_curr(5,:)');
    bin_dpm_curr_sort=bin_dpm_curr(idx_box);
    bin_dpm_obj_map=bin_dpm_obj_map(idx_box);
    
    box_og_curr=strfind(record_on_ground(1,:),im_list{im_no});
    box_og_curr=cellfun(@isempty,box_og_curr);
    box_og_curr=~box_og_curr;
    
    
    box_og_curr=record_on_ground{2,box_og_curr};
    box_og_curr=box_og_curr+1;
    
    
    cmp_og_bin=zeros(size(bin_dpm_curr,1),1);
    cmp_og_bin(box_og_curr)=1;
    
    
    box_kept_curr=strfind(record_cell(end,:),im_list{im_no});
    box_kept_curr=cellfun(@isempty,box_kept_curr);
    box_kept_curr=~box_kept_curr;
    if sum(box_kept_curr)==0
        continue
    end
    
    box_kept_curr=record_cell{4,box_kept_curr};
    box_kept_curr=box_kept_curr(:,1)+1;
    cmp_kept_bin=zeros(size(cmp_og_bin));
    
    idx_og=find(cmp_og_bin>0);
    idx_og_kept=idx_og(box_kept_curr);
    cmp_kept_bin(idx_og_kept)=1;
    
    box_kept_curr=strfind(record_cell(end,:),im_list{im_no});
    box_kept_curr=cellfun(@isempty,box_kept_curr);
    box_kept_curr=~box_kept_curr;
    
    box_kept_curr=record_cell{1,box_kept_curr};
    box_kept_curr=box_kept_curr(:,1)+1;
    cmp_kept_ls_bin=zeros(size(cmp_og_bin));
    
    idx_og=find(cmp_og_bin>0);
    idx_og_kept=idx_og(box_kept_curr);
    cmp_kept_ls_bin(idx_og_kept)=1;
%     bin_dpm_obj_map
    [bin_match,bin_dpm_new]=getBinMatchWithObjMap(bin_dpm_curr_sort,bin_dpm_obj_map,cmp_kept_bin);    
    accuracy_cell{1,im_no}=[bin_match,bin_dpm_new];
    [bin_match,bin_dpm_new]=getBinMatchWithObjMap(bin_dpm_curr_sort,bin_dpm_obj_map,cmp_kept_ls_bin);    
    accuracy_cell{2,im_no}=[bin_match,bin_dpm_new];
    [bin_match,bin_dpm_new]=getBinMatchWithObjMap(bin_dpm_curr_sort,bin_dpm_obj_map,cmp_og_bin);    
    accuracy_cell{3,im_no}=[bin_match,bin_dpm_new];
    accuracy_cell{4,im_no}=im_list{im_no};
%     keyboard;
end