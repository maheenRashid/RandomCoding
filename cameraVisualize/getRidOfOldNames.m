function [old_name,old_pred]=getRidOfOldNames(old_name,old_pred,list_names)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%     old_pred_orig=old_pred;
%     old_name_orig=old_name;
    
    for i=1:numel(list_names)
        curr_name=list_names{i};
        bin=strcmp(old_name(:,1),curr_name);
        old_name(bin,:)=[];
        for cat_no=1:16
            old_list_curr=old_pred{2,cat_no};
            bin=strfind(old_list_curr,curr_name);
            bin=cellfun(@isempty,bin);
            bin=~bin;
            old_list_curr(bin)=[];
            old_pred{2,cat_no}=old_list_curr;
            
            old_pred_curr=old_pred{1,cat_no};
            old_pred_curr(bin)=[];
            old_pred{1,cat_no}=old_pred_curr;
            
%             if numel(find(bin))>0
%                 keyboard;
%             end
        end
    end
end

