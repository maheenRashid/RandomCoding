ccc

load('record_labelMe_withPolyMask.mat');
im_cat=imread('raw_cat_mask.png');
im_obj=imread('raw_object_mask.png');

model_name='b#bedroom#sun_acatrrefqylllzgx';

str_labels={'bed','ns','ct','couch','chair'};
mapping=[1,8,9,2,4];


figure;imagesc(im_cat); axis off;
figure;imagesc(im_obj);axis off;

mod_no=find(strcmp(model_name,record_labelMe(1,:)));
objects=record_labelMe{2,mod_no};


[group_ids,cat_no_aft,cat_no_bef]=getNewLabels(objects,im_cat,im_obj,str_labels,mapping);



