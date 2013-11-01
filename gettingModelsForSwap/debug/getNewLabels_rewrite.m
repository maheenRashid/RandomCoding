function [group_ids,cat_no_aft,cat_no_bef]=getNewLabels_rewrite(objects,im_cat,im_obj,str_labels,mapping)

im_labelMe=zeros(size(objects{end,1}));
for i=1:size(objects,2)
    im_labelMe(objects{end,i})=i;
end

group_ids=unique(im_obj);
group_ids(group_ids==0)=[];
cat_no_bef=zeros(size(group_ids));

label_idx=zeros(numel(group_ids),2);

for i=1:size(group_ids)
    
    count=im_labelMe(im_obj==group_ids(i));
    [label_curr,freq_curr]=mode(count);
    label_idx(i,1)=label_curr;
    label_idx(i,2)=freq_curr;
    
    count=double(im_cat(im_obj==group_ids(i)));
    count(count==0)=[];
    cat_no_bef(i)=mode(count);
    
end

label_idx(4,1)=1;

cat_no_aft=-1*ones(size(group_ids));

labels_uni=unique(label_idx(:,1));
for i=1:numel(labels_uni)
    label_curr=labels_uni(i);
    if label_curr==0
        continue
    end
    
    count=sum(label_curr==label_idx(:,1));
    if count>1
        idx_lab=find(label_curr==label_idx(:,1));
        [~,idx_max]=max(label_idx(idx_lab,2),[],1);
        idx_to_keep=idx_lab(idx_max);
        
    else
        idx_to_keep=find(label_curr==label_idx(:,1));
    end
    
    label=objects{1,label_curr};
    cat_no_aft(idx_to_keep)=mapping(strcmp(str_labels,label));
end




