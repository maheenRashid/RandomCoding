function [ im_vec ] = getVectorsFromWindows( im,boxes,show )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


im_insides=cell(1,numel(boxes));
for i=1:numel(im_insides)
    im_insides{i}=getBoxImage(boxes{i},im);
end

% figure;
im_vec=zeros(numel(boxes),size(im,3));
for box_no=1:size(im_vec,1)
    im_curr=im_insides{box_no};
%     subplot(1,2,1);
%     imshow(im_curr);
    for im_layer=1:size(im_vec,2)
        im_curr_layer=im_curr(:,:,im_layer);
        im_vec(box_no,im_layer)=mean(im_curr_layer(:));
%         subplot(1,2,2)
%         imshow(im_curr_layer);
%         title(num2str(im_vec(box_no,im_layer)));
%         pause;
    end
end



if show>0
    h=figure;
    subplot(1,2,1);
    imshow(im);
    for i=1:numel(boxes)
        subplot(1,2,1);
        plotBoxes(h,boxes{i},'-b');
        subplot(1,2,2);
        imshow(im_insides{i});
        title(num2str(im_vec(i,:)));
        pause;
    end
end
end

