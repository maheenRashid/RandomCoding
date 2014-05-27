function [os_pw]=getPairwisePixelOverlap(polys_1,polys_2,masks_bin,masks_size)
masks_1=polys_1;
masks_2=polys_2;
if masks_bin(1)==0
    masks_1=getMasksFromPoly(polys_1,masks_size);
end
if masks_bin(2)==0
    masks_2=getMasksFromPoly(polys_2,masks_size);
end

os_pw=zeros(numel(masks_1),numel(masks_2));
for m_1=1:numel(masks_1)
    for m_2=1:numel(masks_2)
        os_pw(m_1,m_2)=getPixelWiseOverlap_masks(masks_1{m_1},masks_2{m_2});
    end
end


end

function [mask]=getMasksFromPoly(polys,mask_size)
    if ~iscell(polys)
        polys={polys};
    end
    
    mask=cell(size(polys));
    for i=1:numel(polys)
        poly=polys{i};
        mask{i}=logical(poly2mask(poly(1,:),poly(2,:),mask_size(1),mask_size(2)));
    end
    
end