function overlap=getPixelWiseOverlap(mask1,mask2)
    union=mask1 | mask2;
    intersection=mask1 & mask2;
    
    overlap=sum(intersection)/sum(union);
    
    
%     figure;
%     subplot(1,2,1);
%     imshow(union);
%     subplot(1,2,2);
%     imshow(intersection);
    
    
    
    
end    