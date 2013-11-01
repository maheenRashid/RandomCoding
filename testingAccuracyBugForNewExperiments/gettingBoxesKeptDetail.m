ccc

folders_child={'swapObjectsInBox_allOffsets_sizeComparison_bestSortedByDPMScore_auto_html'   
'swapObjectsInBox_allOffsets_sizeComparison_bestSortedByDPMScore_gt_html'     
'swapObjectsInBox_allOffsets_sizeComparison_bestSortedByPredScore_auto_html'  
'swapObjectsInBox_allOffsets_sizeComparison_bestSortedByPredScore_gt_html'};


folders_parent={'swapObjectsInBox_allOffsets_sizeComparison_bugFixed_html'
'swapObjectsInBox_allOffsets_sizeComparison_bugFixed_gt_html'
'swapObjectsInBox_allOffsets_sizeComparison_bugFixed_html'
'swapObjectsInBox_allOffsets_sizeComparison_bugFixed_gt_html'};


for i=1:numel(folders_child)
    load(fullfile(folders_child{i},'boxes_we_kept.mat'),'record_cell');
    
    boxes_ids=record_cell([4,6],:);
    load(fullfile(folders_parent{i},'boxes_we_kept.mat'),'record_cell');
    boxes_details=record_cell([1,6],:);
    
    for skp_no=1:size(record_cell,2)
        if isempty(boxes_ids{1,skp_no})
            continue
        end
        idx_details=find(strcmp(boxes_ids{2,skp_no},boxes_details(2,:)));
        if numel(idx_details)~=1
            keyboard;
        end
        [C,IA,IB] = intersect(boxes_ids{1,skp_no}(:,1),boxes_details{1,idx_details}(:,1),'stable');
        details_curr=boxes_details{1,idx_details}(IB,:);
        boxes_ids{1,skp_no}=details_curr;
    end
    
    save(fullfile(folders_child{i},'boxes_kept_detail.mat'),'boxes_ids');
    
end