function [rot_diff]=getRotationDifference(map,gt_group,gt_rots,pred_rots,dpm_thresh,quadrant)
% map=rec_dpm.gt_skp_map;
% gt_group=rec_gt.groups;
% gt_rots=rec_gt.orients;
% pred_rots=accu.rots;

if nargin<6
    quadrant=1;
end

map_rots=getMapRots(map,gt_group,gt_rots);
map_rots=map_rots(dpm_thresh>0);

rot_diff=inf(size(map_rots));
idx=find(map_rots>0);

if numel(idx)==0
    return
else
    for i=1:numel(idx)
        rot_diff(idx(i))=getDiff(map_rots(idx(i)),pred_rots(idx(i)),quadrant);
    end
end




end

function map_rots=getMapRots(map,gt_group,gt_rots)
idx_val=find(map>0);
map_rots=zeros(size(map));
for i=1:numel(idx_val)
    idx_val_curr=idx_val(i);
    group_curr=map(idx_val_curr);
    bin=gt_group==group_curr;
    gt_rot_curr=gt_rots(bin);
    if numel(gt_rot_curr)>0
        if sum(gt_rot_curr)>0
            gt_rot_curr(gt_rot_curr==0)=[];
        else
            gt_rot_curr=gt_rot_curr(1);
        end
    end
    map_rots(idx_val_curr)=gt_rot_curr;
end

end


function rot_diff=getDiff(gt_o,pred_o,quadrant)
rot_diff=inf;

gt_o=changeToQuad1(gt_o,quadrant);

mod_gt=mod(gt_o,2);
mod_pred=mod(pred_o,2);

if mod_gt==0 && gt_o==pred_o
    rot_diff=0;
    return;
end

if mod_gt==1 && mod_pred==1 && gt_o~=pred_o
    rot_diff=0;
    return;
end

if mod_pred==mod_gt
    rot_diff=180;
    return;
end

rot_diff=90;

end


function gt_o=changeToQuad1(gt_o,quadrant)

    if quadrant==1
        return;
    end
    
    if quadrant==3
       gt_o=mod(gt_o+2,4);
       if gt_o==0
           gt_o=4;
       end
    elseif quadrant==4
       gt_o=gt_o-1;
       if gt_o==0
           gt_o=4;
       end
    elseif quadrant==2
       gt_o=gt_o+1;
       if gt_o==5
           gt_o=1;
       end
    end
end