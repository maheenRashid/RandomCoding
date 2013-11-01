ccc
load('dpm_greater_-1_bbox_record_withDetections.mat','record');
load('record_detections.mat');



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



mod_no=2;
id_name=record_detections(mod_no).id_name;
match_id=record_detections(mod_no).match_name;
boxes=record_detections(mod_no).boxes;
masks=record_detections(mod_no).masks;
cat_nos=record_detections(mod_no).cat_no_aft;

id_temp=regexpi(id_name,'#','split');
id_temp=id_temp{end};
idx=strcmp(id_temp,record(2,:));
dpms=record(:,idx);

dpms_str=cell(1,0);
for dpm_no=1:size(dpms,2)
    box_curr=dpms{3,dpm_no};
    cell_curr=cell(1,size(box_curr,1));
    [cell_curr{1,:}]=deal(dpms{1,dpm_no});
    dpms_str=[dpms_str cell_curr];
end
dpms_str=dpms_str';
dpm_boxes=cell2mat(dpms(3,:)');
dpm_bin=cell2mat(dpms(4,:)');
dpm_objmap=cell2mat(dpms(5,:)');

dpm_cat_no=cellfun(@(x) mapping(strcmp(x,str_labels)),dpms_str);

dpm_bbox_overlap=zeros(numel(dpm_cat_no),numel(cat_nos));

for dpm_no=1:numel(dpm_cat_no)
    for det_no=1:numel(cat_nos)
        if numel(boxes{det_no})==0
            dpm_bbox_overlap(dpm_no,det_no)=0;
        else
            dpm_bbox_overlap(dpm_no,det_no)=getBBoxOverlap(dpm_boxes(dpm_no,1:4),boxes{det_no});
        end
    end
end

record_detections(mod_no).dpm_bbox_overlap=dpm_bbox_overlap;

record_detections(mod_no).dpm_boxes=dpm_boxes;
record_detections(mod_no).dpm_bin=dpm_bin;
record_detections(mod_no).dpm_objmap=dpm_objmap;
record_detections(mod_no).dpm_cat_no=dpm_cat_no;


