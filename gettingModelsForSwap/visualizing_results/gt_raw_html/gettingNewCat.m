close all;clear;clc;

load('record_new_labels_bad_names_in_file_data.mat','record_new_labels');

% name: 'b#bedroom#sun_acegsfqslzpitbyu'
%        group_ids: [2x1 uint8]
%       cat_no_aft: [2x1 double]
%       cat_no_bef: [2x1 double]
%       cat_no_all: [2x1 double]
%     group_id_all: [2x1 double]


for mod_no=1:numel(record_new_labels)
    cat_all=record_new_labels(mod_no).cat_no_all;
    group_all=record_new_labels(mod_no).group_id_all;
    cat_no_aft=record_new_labels(mod_no).cat_no_aft;
    group_id_uni=record_new_labels(mod_no).group_ids;
    id=record_new_labels(mod_no).name;
    
    if numel(group_all)~=numel(group_id_uni)
        disp('debug time')
    end
    cat_no_aft_no_minus=cat_no_aft;
    new_cat=zeros(size(cat_all));
    for i=1:numel(group_all)
        idx=group_id_uni==group_all(i);
        if sum(idx)==0
            new_cat(i)=cat_all(i);
        elseif cat_no_aft(idx)==-1 
            new_cat(i)=cat_all(i);
            cat_no_aft_no_minus(idx)=cat_all(i);
        else
            new_cat(i)=cat_no_aft(idx);
        end
    end
    
    bin_relabel=cat_all~=new_cat;
    record_new_labels(mod_no).new_cat_all=new_cat;
    record_new_labels(mod_no).bin_relabel=bin_relabel;
    record_new_labels(mod_no).cat_no_aft_no_minus=cat_no_aft_no_minus;
end


save('record_new_labels_with_new_cat.mat','record_new_labels');
