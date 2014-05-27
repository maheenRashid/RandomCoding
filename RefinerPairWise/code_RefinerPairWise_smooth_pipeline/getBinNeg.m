function [bin_neg]=getBinNeg(box_nos,boxes)
    

box_nos=box_nos+1;

boxes=boxes(box_nos,:);

bin_neg=zeros(size(boxes,1),1);
for box_no=1:size(boxes,1)
    box_curr=boxes(box_no,:);
    box_curr=reshape(box_curr,3,2);
    box_curr=box_curr';
    bin=box_curr<0;
    bin=sum(bin,1);
    bin_neg(box_no)=sum(bin==2);
end

end