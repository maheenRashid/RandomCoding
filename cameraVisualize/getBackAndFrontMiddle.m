function  [pt_back,pt_front]=getBackAndFrontMiddle(mergedA,pred_curr)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
if mod(numel(mergedA),2)~=0
    mergedA=mergedA(1:end-1);
end
pts=mergedA(1:2:end);
pts=pts';
pts=cell2mat(pts);
min_pts=min(pts);
max_pts=max(pts);
mid_pts=(min_pts+max_pts)/2;
if pred_curr==1
    pt_back=[mid_pts(1) max_pts(2)  min_pts(3)]';
    pt_front=[mid_pts(1) min_pts(2)  min_pts(3)]';
elseif pred_curr==2
    pt_back=[ max_pts(1) mid_pts(2)  min_pts(3)]';
    pt_front=[ min_pts(1) mid_pts(2)  min_pts(3)]';
elseif pred_curr==3
    pt_back=[mid_pts(1) min_pts(2)  min_pts(3)]';
    pt_front=[mid_pts(1) max_pts(2)  min_pts(3)]';
elseif pred_curr==4
    pt_back=[ min_pts(1) mid_pts(2)  min_pts(3)]';
    pt_front=[ max_pts(1) mid_pts(2)  min_pts(3)]';
end

end

