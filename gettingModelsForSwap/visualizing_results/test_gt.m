ccc
parent_dir= 'E:\RandomCoding\gettingModelsForSwap\visualizing_results';
folder='swapModelInBox_bestSortedByDPMScore_auto_html';
load(fullfile(parent_dir,folder,'record_detections_gt.mat'));

% 1x480 struct array with fields:
%     id_name
%     match_name
%     group_id
%     cat_no_aft
%     boxes
%     masks
%     bin_visibility
%     pixelwise_overlap
%     bbox_overlap
%     gt_cat_no
%     gt_masks
%     gt_boxes

gt_cat_no={record_detections(:).gt_cat_no};
empty_idx=find(~cellfun(@isempty,gt_cat_no));
gt_cat_no=gt_cat_no(empty_idx);
det_cat_no={record_detections(empty_idx).cat_no_aft};

bbox_overlap={record_detections(empty_idx).bbox_overlap};

det_overlap=cell(size(det_cat_no));
det_cat=cell(size(det_cat_no));

for i=1:numel(det_cat_no)
    gt_cat_curr=gt_cat_no{i};
    det_cat_curr=det_cat_no{i};
    bol_curr=bbox_overlap{i};
    
    [val,idx]=max(bol_curr,[],2);
    k=unique(idx);
    
    for temp=1:numel(k)
        val_curr=val(idx==k(temp));
        if numel(val_curr)>1
            idx_idx=find(idx==k(temp));
            [~,max_idx]=max(val_curr);
            bin_idx=ones(size(idx_idx));
            bin_idx(max_idx)=0;
            val(idx_idx(bin_idx>0))=0;
        end
    end
    
    det_cat{i}=det_cat_curr(idx);
    det_overlap{i}=val;
    
end

overlap_vec=cell2mat(det_overlap');
det_cat_vec=cell2mat(det_cat');
gt_cat_vec=cell2mat(gt_cat_no)';
%  
%
thresh=0.3

types=unique(gt_cat_vec);
for t_no=1:numel(types)
    type_curr=types(t_no)
    overall=sum(overlap_vec>thresh & det_cat_vec==gt_cat_vec & gt_cat_vec==type_curr)/numel(gt_cat_vec==type_curr)


end
% pos=(ovelap_vec>thresh & det_cat_vec==gt_cat_vec)/numel(gt_cat_vec)

