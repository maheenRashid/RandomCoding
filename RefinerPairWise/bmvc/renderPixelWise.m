function [threshes_rep,det_rates]=renderPixelWise(det_record_cell,idx,threshes)
    dets_rel=det_record_cell(idx);
    dets_rel=cellfun(@fixIds,dets_rel,'UniformOutput',0);
    ids_rel=cellfun(@(x) {x.id},dets_rel,'UniformOutput',0);
    [ids_int,idx_keep]=getIntersectionIds(ids_rel);
    dets_rel=cellfun(@(x,y) x(y),dets_rel,idx_keep,'UniformOutput',0);
    
    overlaps=cellfun(@(x) getDetRate({x.det_overlap},threshes),dets_rel,'UniformOutput',0);
    
    
    det_rates=cell2mat(overlaps');
    threshes_rep=repmat(threshes,size(det_rates,1),1);
%     h=figure; plot(threshes_rep',det_rates');

end

function [det_record]=fixIds(det_record)
    ids={det_record(:).id};
    ids=cellfun(@(x) strrep(x,'b#bedroom#',''),ids,'UniformOutput',0);
    ids=cellfun(@(x) strrep(x,'l#living_room#',''),ids,'UniformOutput',0);
    ids=cellfun(@(x) strrep(x,'.mat',''),ids,'UniformOutput',0);
    [det_record(:).id]=deal(ids{:});
end

function [ids_int,idx_keep]=getIntersectionIds(ids_rel)
    if numel(ids_rel)==1
        ids_int=ids_rel{1};
        return;
    end
    
    first=ids_rel{1};
    for i=2:numel(ids_rel)
        ids_int=intersect(first,ids_rel{i});
        first=ids_int;
    end
    
    idx_keep=cell(size(ids_rel));
    for i=1:numel(ids_rel)
        [~,~,idx_b]=intersect(ids_int,ids_rel{i});
        idx_keep{i}=idx_b;
    end

end
