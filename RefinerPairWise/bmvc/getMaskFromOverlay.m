function [mask_3d]=getMaskFromOverlay(im,im_2)
    
im_2=im_2-im/2;
mask=sum(im_2,3);
mask=mask>0;
mask_3d=cat(3,mask,mask,mask);
mask_3d=uint8(mask_3d);
end

