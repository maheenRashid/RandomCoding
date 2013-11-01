function [bin]=getBinFromList(list,no_boxes,box_nos,idx_on_ground)
bin=zeros(no_boxes,1);
bin(idx_on_ground(box_nos(list)))=1;
end