function [h,h1]=visualizeBoxPreds(im,feature_curr,gt_box,pred_box,str_boxes)

if nargin<5
    str_boxes={'-k','-r'};
end

h=figure;
     imshow(im);
     h1=figure;
     imshow(im);
     for box_no=1:size(feature_curr,1)
        plotBoxes(h,feature_curr(box_no,1:4),str_boxes{gt_box(box_no)+1});
        plotBoxes(h1,feature_curr(box_no,1:4),str_boxes{pred_box(box_no)+1});
     end
     

end

