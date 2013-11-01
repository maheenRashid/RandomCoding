ccc
% load('E:\RandomCoding\gettingModelsForSwap\camera_problem_gt\record_new_labels_with_new_cat.mat')
% meta_dir='E:\RandomCoding';
%
% im_dir=fullfile(meta_dir,'writingDpmFiles/gt_models');
% x=dir(im_dir);
%     x=x(3:end);
% names={x(:).name};
% im_sizes=[names;cell(1,numel(names))];
% for c=1:numel(x);
% im=imfinfo(fullfile(im_dir,names{c},'raw_image.jpg'));
% im_size=[im.Height im.Width];
% im_sizes{2,c}=im_size;
% end
%
% save('im_sizes.mat','im_sizes');
%
%
% return
% ccc
load('record_detections.mat');
load('im_sizes.mat');
meta_dir='E:\RandomCoding';
load(fullfile(meta_dir,'downloadingAnnotations','record_labelMe_combined.mat'));
im_dir=fullfile(meta_dir,'writingDpmFiles/gt_models');


str_labels={'bed','ns','ct','couch','chair'};
mapping=[1,8,9,2,4];



mod_no=2;
id_name=record_detections(mod_no).id_name;
match_id=record_detections(mod_no).match_name;
boxes=record_detections(mod_no).boxes;
masks=record_detections(mod_no).masks;
cat_nos=record_detections(mod_no).cat_no_aft;

gt=strcmp(id_name,record_labelMe(1,:));
gt=record_labelMe{2,gt};

gt_cat_no=cellfun(@(x) mapping(strcmp(x,str_labels)),gt(1,:));

pixelwise_overlap=zeros(numel(gt_cat_no),numel(cat_nos));
bbox_overlap=zeros(numel(gt_cat_no),numel(cat_nos));

gt_boxes=gt(3,:);
gt_polys=gt(2,:);


im_size=im_sizes{2,strcmp(id_name,im_sizes(1,:))};

gt_masks=cellfun(@(x) poly2mask(double(x(1,:)),double(x(2,:)),im_size(1),im_size(2)),gt_polys,'UniformOutput',0);

for gt_no=1:numel(gt_cat_no)
    for det_no=1:numel(cat_nos)
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


return

for i=1:numel(gt_masks)
    figure;
    imshow(gt_masks{i});
end

h=figure;
imshow(im);

for i=1:size(gt,2)
    hold on;
    title(gt_cat_no(i));
    plot(gt{2,i}(1,:),gt{2,i}(2,:),'-r');
    plotBoxes(h,gt{3,i},'-r',2);
end

h_det=figure;
imshow(im)
for i=1:numel(cat_nos)
    hold on;
    title(num2str(cat_nos(i)))
    plotBoxes(h_det,boxes{i},'-r',2);
end






























