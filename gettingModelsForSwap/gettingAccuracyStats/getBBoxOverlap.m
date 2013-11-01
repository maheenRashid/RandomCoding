function overlap=getBBoxOverlap(box1,box2)
    if numel(box1)==4
        box1=double(getBoxPts(box1));
        box2=double(getBoxPts(box2));
    end
    
    [ux,uy]=polybool('+',box1(1,:),box1(2,:),box2(1,:),box2(2,:));
    [ix,iy]=polybool('&',box1(1,:),box1(2,:),box2(1,:),box2(2,:));
    ua=polyarea(ux,uy);
    ia=polyarea(ix,iy);
    
    overlap=ia/ua;
    
    if isnan(overlap)
        overlap=0;
    end
    
%     figure;
%     subplot(1,2,1);
%     plot(ux,uy,'-r');
%     subplot(1,2,2);
%     plot(ix,iy,'-b');
    
end

    