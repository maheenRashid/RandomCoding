function [group_ids,cat_no_aft,cat_no_bef]=getNewLabels(objects,im_cat,im_obj,str_labels,mapping)

im_labelMe=zeros(size(objects{end,1}));
for i=1:size(objects,2)
    im_labelMe(objects{end,i})=i;
end
figure;
imagesc(im_labelMe);

group_ids=unique(im_obj);
group_ids(group_ids==0)=[];
cat_no_bef=zeros(size(group_ids));
cat_no_aft=zeros(size(group_ids));
for i=1:size(group_ids)
    
    count=im_labelMe(im_obj==group_ids(i));
    count(count==0)=[];
    label_idx=mode(count);
    
    count=double(im_cat(im_obj==group_ids(i)));
    count(count==0)=[];
    cat_no_bef(i)=mode(count);
    
    if isnan(label_idx)
    cat_no_aft(i)=-1;
    else
        
    
    label=objects{1,label_idx};
    cat_no_aft(i)=mapping(strcmp(str_labels,label));
    end
    

end
