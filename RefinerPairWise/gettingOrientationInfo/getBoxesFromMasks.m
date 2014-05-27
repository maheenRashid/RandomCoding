function [boxes]=getBoxesFromMasks(masks)
    boxes=cell(size(masks));
    for i=1:numel(masks)
       [x,y]=find(masks);
       box=[x(:)';y(:)'];
       box=[min(box,[],2),max(box,[],2)];
       box=box(:);
       boxes{i}=box';
    end
end