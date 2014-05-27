function [det_rate]=getDetRate(dets,threshes)

    
    dets=cell2mat(dets');
    det_rate=zeros(size(threshes));
    for thresh_no=threshes
        dets_curr=dets>thresh_no;
        det_rate(thresh_no==threshes)=sum(dets_curr)/numel(dets_curr);
    end

end