ccc

% load (fullfile('..','swapModel_allBoxes_bestSortedByDPMScore_gt_withText_html','record_overlaps.mat'));
load (fullfile('..','swapModel_allBoxes_bestSortedByDPMScore_gt_withText_html','record_overlaps.mat'));

for model_no=1:numel(record_overlaps)

match_data=record_overlaps(model_no).match_data;
for match_no=1:numel(record_overlaps(model_no).match_data)


strs=match_data(match_no).strs;

strs_rep=cellfun(@(x) strrep(x,' ','_'),strs,'UniformOutput',0);
numbers=match_data(match_no).numbers;

for i=1:numel(strs_rep)
    evalc(['match_data(match_no).' strs_rep{i} '=numbers{' num2str(i) '}']);
end


minMax_dpm=match_data(match_no).minMax_dpm(:,[1,2,4,5]);
minMax_skp=match_data(match_no).minMax_skp(:,[1,2,4,5]);



box_overlap=zeros(size(minMax_dpm,1),size(minMax_skp,1));
for i=1:size(box_overlap,1)
    for j=1:size(box_overlap,2)
        box_overlap(i,j)=getBoxOverlap(minMax_dpm(i,:),minMax_skp(j,:));
    end
end

match_data(match_no).box_overlap=box_overlap;
end
record_overlaps(model_no).match_data=match_data;
end

save(fullfile('..','swapModel_allBoxes_bestSortedByDPMScore_gt_withText_html','record_overlaps.mat'));


% h=figure;
% strs_disp={'-r','-m'};
% cell_floor={minMax_dpm,minMax_skp};
% for i=1:numel(cell_floor)
%     boxes=cell_floor{i};
%     for j=1:size(boxes,1)
%         plotBoxes(h,boxes(j,:),strs_disp{i},2);
%     end
% end
