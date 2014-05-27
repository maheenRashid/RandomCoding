function [rot_dif]=getRotationDifference_gt(overlap,pred_rots,gt_rots,quad,thresh)


bin_det=overlap>=thresh;
pred_rots=pred_rots(bin_det);
gt_rots=gt_rots(bin_det);

rot_dif=inf(size(gt_rots));

for pred_no=1:numel(pred_rots)
    gt_rot=gt_rots(pred_no);
    pred_rot=pred_rots(pred_no);
    if gt_rot==0
        continue;
    end
    rot_dif(pred_no)=getDiff(gt_rot,pred_rot,quad);
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