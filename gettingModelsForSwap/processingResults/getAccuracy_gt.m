
load(fullfile(dir_parent,[folder '_html'],'record_detections.mat'),'record_detections');
load('im_sizes.mat');
load('record_labelMe_combined.mat');

str_labels={'bed','ns','ct','couch','chair'};
mapping=[1,8,9,2,4];

        tmp=cell(size(record_detections)); 

        [record_detections(:).pixelwise_overlap]=deal(tmp{:});
        [record_detections(:).bbox_overlap]=deal(tmp{:});
        [record_detections(:).gt_cat_no]=deal(tmp{:});
        [record_detections(:).gt_masks]=deal(tmp{:});
        [record_detections(:).gt_boxes]=deal(tmp{:});

matlabpool open
parfor mod_no=1:numel(record_detections)
    id_name=record_detections(mod_no).id_name;
    match_id=record_detections(mod_no).match_name;
    boxes=record_detections(mod_no).boxes;
    masks=record_detections(mod_no).masks;
    cat_nos=record_detections(mod_no).cat_no_aft;
    
    gt=strcmp(id_name,record_labelMe(1,:));
    if sum(gt)==0
        continue
    end
    
    gt=record_labelMe{2,gt};
    
    gt_cat_no=cellfun(@(x) mapping(strcmp(x,str_labels)),gt(1,:));
    
    pixelwise_overlap=zeros(numel(gt_cat_no),numel(cat_nos));
    bbox_overlap=zeros(numel(gt_cat_no),numel(cat_nos));
    
    gt_boxes=gt(3,:);
    gt_polys=gt(2,:);
    
    
    im_size=im_sizes{2,strcmp(id_name,im_sizes(1,:))};
    
    gt_masks=cellfun(@(x) poly2mask(double(x(1,:)),double(x(2,:)),im_size(1),im_size(2)),gt_polys,'UniformOutput',0);
    
    for gt_no=1:numel(gt_cat_no)
        for det_no=1:numel(boxes)
            if numel(boxes{det_no})==0
                pixelwise_overlap(gt_no,det_no)=0;
                bbox_overlap(gt_no,det_no)=0;
            else
                pixelwise_overlap(gt_no,det_no)=getPixelWiseOverlap(gt_masks{gt_no},masks{det_no});
                bbox_overlap(gt_no,det_no)=getBBoxOverlap(gt_boxes{gt_no},boxes{det_no});
            end
        end
    end
    
    gt_masks=cellfun(@(x) sparse(x),gt_masks,'UniformOutput',0);
    
    record_detections(mod_no).pixelwise_overlap=pixelwise_overlap;
    record_detections(mod_no).bbox_overlap=bbox_overlap;
    record_detections(mod_no).gt_cat_no=gt_cat_no;
    record_detections(mod_no).gt_masks=gt_masks;
    record_detections(mod_no).gt_boxes=gt_boxes;
end
matlabpool close

save(fullfile(dir_parent,[folder '_html'],'record_detections_gt.mat'),'record_detections');
