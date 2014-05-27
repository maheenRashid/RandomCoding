ccc

load(fullfile('..','dpm_greater_-1_bbox_record_withDetections'),...
    'record_labelMe');

%get all the strs
% second_row=record_labelMe(2,:);
% str_cell=cell(1,0);
% for i=1:numel(second_row)
%     temp=second_row{i};
%     str_cell=[str_cell temp{1,:}];
% end
% strs=unique(str_cell);

str_labels={'bed','ns','ct','couch','chair'};
mapping=[1,8,9,2,4];
dummy=cell(1,size(record_labelMe,2));
record_gt=struct('id',dummy,'labels',dummy,'boxes',dummy,'polys',...
    dummy,'bin_det',dummy);

for i=1:size(record_labelMe,2)

    id=record_labelMe{1,i};
    gt_info=record_labelMe{2,i};
    labels=gt_info(1,:);
    labels=cellfun(@(x) mapping(strcmp(x,str_labels)),labels);
    boxes=cellfun(@double,gt_info(3,:),'uniformoutput',0);
    polys=cellfun(@double,gt_info(2,:),'uniformoutput',0);
    if size(gt_info,1)==4
        bin_det=cell2mat(gt_info(4,:));
    end
    record_gt(i).id=id;
    record_gt(i).labels=labels;
    record_gt(i).boxes=boxes;
    record_gt(i).polys=polys;
    record_gt(i).bin_det=bin_det;

end

save('record_gt.mat','record_gt');