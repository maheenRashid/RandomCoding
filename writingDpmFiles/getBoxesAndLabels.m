function [boxes,labels] = getBoxesAndLabels (catMask,show)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

if nargin<2
    show=0;
end

cat_lab=bwlabel(catMask);
objects=unique(cat_lab);
labels=zeros(0,1);
boxes=zeros(0,4);
for obj_no=1:numel(objects)
    [x,y]=find(cat_lab==objects(obj_no));
    
    cat_picked=catMask(sub2ind(size(cat_lab),x,y));
    cat=unique(cat_picked);
    
%     if numel(cat)~=1
%         disp('error.');
%         objects(obj_no)
%         cat
%         bin=zeros(size(cat_lab));
%         bin(sub2ind(size(cat_lab),x,y))=1;
%         figure;
%         imagesc(bin);
%         keyboard;
%     end
    for cat_no=1:numel(cat)
        [x,y]=find(cat_lab==objects(obj_no) & catMask==cat(cat_no));
        
        x_min=min(y);
        x_max=max(y);
        y_min=min(x);
        y_max=max(x);
        
        box_curr=[x_min,y_min,x_max,y_max];
        
        if (x_max-x_min)*(y_max-y_min)<10
            continue
        end
        
        
        boxes=[boxes;box_curr];
        labels=[labels;cat(cat_no)];
        
        if show>0
            h=figure;
            imagesc(catMask);
            plotBoxes(h,box_curr,'-r');
            title(num2str(cat(cat_no)))
            keyboard
        end
    end
end

end

