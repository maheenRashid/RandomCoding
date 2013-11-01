ccc
parent_dir= 'E:\RandomCoding\gettingModelsForSwap\visualizing_results';
folder='swapModelInBox_bestSortedByDPMScore_auto_html';
load(fullfile(parent_dir,folder,'record_detections_dpm.mat'));

% 1x486 struct array with fields:
%     id_name
%     match_name
%     group_id
%     cat_no_aft
%     boxes
%     masks
%     bin_visibility
%     dpm_bbox_overlap
%     dpm_boxes
%     dpm_bin
%     dpm_objmap
%     dpm_cat_no

dpm_bin={record_detections(:).dpm_bin};
idx=find(~cellfun(@isempty,dpm_bin));
% idx=idx(1);
dpm_bin=dpm_bin(idx);

match_names={record_detections(idx).match_name};
group_ids={record_detections(idx).group_id};
cat_no_aft={record_detections(idx).cat_no_aft};
dpm_cat_no={record_detections(idx).dpm_cat_no};
dpm_bbox_overlap={record_detections(idx).dpm_bbox_overlap};
bin_visibility={record_detections(idx).bin_visibility};

bin_det=cell(size(dpm_bin));

thresh=0.5;
for i=1:numel(dpm_bbox_overlap)
    ol_curr=dpm_bbox_overlap{i};    
    dpm_cat_curr=dpm_cat_no{i};
    cat_all_curr=cat_no_aft{i};
    
    [val,idx]=max(ol_curr,[],2);
    
    cat_curr=cat_all_curr(idx);
    
    valid=val>thresh;
%     & dpm_cat_curr==cat_curr;
    bin_det{i}=valid;
    
end


bin_det_vec=cell2mat(bin_det');
bin_dpm_vec=cell2mat(dpm_bin');

