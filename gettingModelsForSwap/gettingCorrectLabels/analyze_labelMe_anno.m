ccc
load('../../downloadingAnnotations/record_labelMe_combined.mat');
gt_im_dir='E:\RandomCoding\writingDpmFiles\gt_models';


for im_no=1:size(record_labelMe,2)
just_name=record_labelMe{1,im_no};
objects=record_labelMe{2,im_no};
objects=[objects;cell(1,size(objects,2))];
im_dpm=imread(fullfile(gt_im_dir,just_name,'resized_image.jpg'));
for obj_no=1:size(objects,2)
    poly_curr=objects{2,obj_no};
    poly_curr=double(poly_curr);
    BW = poly2mask(poly_curr(1,:),poly_curr(2,:), size(im_dpm,1), size(im_dpm,2));
    objects{end,obj_no}=sparse(BW); 
end
record_labelMe{2,im_no}=objects;
end
