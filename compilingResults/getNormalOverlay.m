function im_overlay_normal=getNormalOverlay(im_overlay,im_normal,im_org)

    
    im_mask=im_overlay-im_org;
    im_mask=rgb2gray(im_mask);
    im_mask=uint8(im_mask>0);
    
    im_normal_mask=im_normal.*repmat(im_mask,[1,1,3]);
    
    im_overlay_normal=im_org+0.5*im_normal_mask;
end
    