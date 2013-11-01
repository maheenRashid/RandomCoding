record_new_labels=struct();

matlabpool open
parfor i=1:numel(dir_models)
    model_name=dir_models(i).name;
    f_path=fullfile(dir_parent,dir_gt,model_name,'renderings');
    if ~exist(fullfile(f_path,'raw_cat_mask.png'),'file')
        model_name
        continue
    end
    im_cat=imread(fullfile(f_path,'raw_cat_mask.png'));
    im_obj=imread(fullfile(f_path,'raw_object_mask.png'));
    
        group_ids=unique(im_obj);
        group_ids(group_ids==0)=[];
        cat_no_aft=zeros(size(group_ids));
        for j=1:size(group_ids)
            count=double(im_cat(im_obj==group_ids(j)));
            cat_no_aft(j)=mode(count);
        end
    record_new_labels(i).name=model_name;
    record_new_labels(i).group_ids=group_ids;
    record_new_labels(i).cat_no_aft=cat_no_aft;
    
end
matlabpool close;

save(fullfile(out_dir,'record_new_labels.mat'),'record_new_labels');
   
