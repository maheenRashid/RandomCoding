function [ featureVec,class ] = getSVMDataFromRecord( record )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

cats=[8,9,10,11,12];

featureVec=zeros(0,4+1+numel(cats)+75+25);
class=zeros(0,1);
for file_no=1:size(record,2)
    boxes_curr=record{3,file_no};
    for box_no=1:size(boxes_curr,1)
        box_dim=boxes_curr(box_no,1:4);
        box_conf=boxes_curr(box_no,end);
        box_cat=record{5,file_no};
        
        box_cat_bin=zeros(size(cats));
        box_cat_bin(box_cat==cats)=1;
        box_cat=box_cat_bin;
        
        box_normal=record{end-1,file_no}{box_no};
        box_munoz=record{end,file_no}{box_no};
        box_normal=box_normal(:)';
        box_munoz=box_munoz(:)';
        
        box_class=record{4,file_no}(box_no);
        featureVec=[featureVec;[box_dim,box_conf,box_cat,box_normal,box_munoz]];
        class=[class;box_class];
    end
end


end

