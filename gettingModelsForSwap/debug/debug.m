ccc
load('debug.mat');
figure;imagesc(im_cat);
figure;imagesc(im_obj);

% [group_ids,cat_no_aft,cat_no_bef]=getNewLabels(objects,im_cat,im_obj,str_labels,mapping);

[group_ids,cat_no_aft,cat_no_bef]=getNewLabels_rewrite(objects,im_cat,im_obj,str_labels,mapping);



return
ccc
% return
dir_parent='/lustre/maheenr/results_temp_09_13';
dir_gt='gt_raw';


dir_models=dir(fullfile(dir_parent,dir_gt));
dir_models=dir_models(3:end);
load('record_labelMe_withPolyMask.mat');
str_labels={'bed','ns','ct','couch','chair'};
mapping=[1,8,9,2,4];

record_new_labels=struct();

% matlabpool open
% parfor i=1:numel(dir_models)
i=1;
    model_name=dir_models(i).name;
    model_name='b#bedroom#sun_afywcuzscjctbdcu'
    f_path=fullfile(dir_parent,dir_gt,model_name,'renderings');
    if ~exist(fullfile(f_path,'raw_cat_mask.png'),'file')
        model_name
        continue
    end
    im_cat=imread(fullfile(f_path,'raw_cat_mask.png'));
    im_obj=imread(fullfile(f_path,'raw_object_mask.png'));
    
    mod_no=find(strcmp(model_name,record_labelMe(1,:)));
    if numel(mod_no)~=1
        group_ids=unique(im_obj);
        group_ids(group_ids==0)=[];
        cat_no_bef=zeros(size(group_ids));
        cat_no_aft=-1*ones(size(group_ids));
        for j=1:size(group_ids)
            count=double(im_cat(im_obj==group_ids(j)));
            cat_no_bef(j)=mode(count);
        end
    else
        objects=record_labelMe{2,mod_no};
        save('debug.mat');
        [group_ids,cat_no_aft,cat_no_bef]=getNewLabels(objects,im_cat,im_obj,str_labels,mapping);
    end
    record_new_labels(i).name=model_name;
    record_new_labels(i).group_ids=group_ids;
    record_new_labels(i).cat_no_aft=cat_no_aft;
    record_new_labels(i).cat_no_bef=cat_no_bef;
    
% end
% matlabpool close;
% 
% save(fullfile(dir_parent,[dir_gt '_html'],'record_new_labels.mat'),'record_new_labels');

