function [boxes]=getBoxesFromMasks(masks)
    boxes=cell(1,numel(masks));
    for i=1:numel(masks)
       [x,y]=find(masks{i});
       box=[y(:)';x(:)'];
       box=[min(box,[],2),max(box,[],2)];
       box=box(:);
       boxes{i}=box';
    end
end