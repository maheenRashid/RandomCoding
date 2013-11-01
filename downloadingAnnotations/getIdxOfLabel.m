
function [record_objects_curr,idx_curr]=getIdxOfLabel(record_labelMe,str_label)
    
    record_objects_curr=cell(size(record_labelMe));
    objects_all=record_labelMe(2,:);
    idx_curr=zeros(1,0);
    for im_no=1:numel(objects_all)
        objects_curr=objects_all{im_no};
        if numel(objects_curr)==1
            continue
        end
        
        labels_curr=objects_curr(1,:);
        bin=strfind(labels_curr,str_label);
        bin=cellfun(@isempty,bin);
        
        bin=~bin;
        if sum(bin)==0
            continue
        end
        
        record_objects_curr{1,im_no}=record_labelMe{1,im_no};
        record_objects_curr{2,im_no}=objects_curr(:,bin);
        idx_curr=[idx_curr,im_no];
%         keyboard;
    end


end