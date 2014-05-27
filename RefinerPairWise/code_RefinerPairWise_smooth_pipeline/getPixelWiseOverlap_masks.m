function [overlap]=getPixelWiseOverlap_masks(mask1,mask2)
    
    un=mask1|mask2;
    inter=mask1&mask2;
    overlap=sum(inter(:))/sum(un(:));
    if isnan(overlap)
        overlap=0;
    end
end