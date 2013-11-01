function [ bin,count,obj ] = isDetection( box,catMask,show )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
bin=0;
temp=catMask>13;
catMask(temp)=13;
catMask=catMask+1;

[cat_box,box]=getImBox(catMask,box);
count=zeros(1,14);
for i=1:numel(count)
    count(i)=sum(sum(cat_box==i));
end

[box_centre]=getCentreWindow(box);

[cat_centre,box_centre]=getImBox(catMask,box_centre);

count_centre=zeros(1,14);
for i=1:numel(count_centre)
    count_centre(i)=sum(sum(cat_centre==i));
end
count_centre(1)=[];
[check,obj]=max(count_centre);
if check==0
    bin=0;
    obj=1;
    return
end
obj=obj+1;
mask_obj=catMask==obj;

mask_obj_centre=getImBox(mask_obj,box_centre);

cat_lab=bwlabel(catMask-1);

cat_lab_centre=getImBox(cat_lab,box_centre);
lab=cat_lab_centre(mask_obj_centre);
lab=mode(lab(:));

%get actual obj now
mask_obj_and_lab=cat_lab==lab & catMask==obj;
total_count=sum(sum(mask_obj_and_lab));
boxed=getImBox(mask_obj_and_lab,box);
window_count=sum(sum(boxed));

if window_count>floor(total_count/2)
    bin=1;
end

if show>0
    figure;
    subplot(1,4,1);
    imagesc(catMask);plotBoxes(gcf,box,'-r');plotBoxes(gcf,box_centre,'-b');
    axis equal;
    subplot(1,4,2);
    imagesc(mask_obj);plotBoxes(gcf,box,'-r');
    axis equal;
    subplot(1,4,3);
    imagesc(cat_lab);plotBoxes(gcf,box,'-r');
    axis equal;
    subplot(1,4,4);
    imagesc(mask_obj_and_lab);plotBoxes(gcf,box,'-r');
    axis equal;
end
end

function [box_centre]=getCentreWindow(box)
noWindows=3;
l=box(3)-box(1);
b=box(4)-box(2);

lStep=ceil(l/noWindows);
bStep=ceil(b/noWindows);

offset=[lStep,bStep,lStep*2,bStep*2];
box_centre=[box(1),box(2),box(1),box(2)]+offset;

end

