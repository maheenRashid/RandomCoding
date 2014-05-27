function [rot_dif]=getRotDiff_Box_Auto(overlap,pred_rots,gt_rots,quad,thresh)

maps=cell(1,4);
maps{1}=[1,1,4,2];
maps{2}=[2,4,1,3];
maps{3}=[3,1,2,4];
maps{4}=[4,2,3,1];
gt_map=[4,2,3,1];

map_rel=maps{quad};

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
    gt_rot_idx=gt_rot==gt_map;
    true_rot=map_rel(gt_rot_idx);
    
    if pred_rot==true_rot
        rot_dif(pred_no)=0;
    elseif mod(true_rot,2)==mod(pred_rot,2)
        rot_dif(pred_no)=180;
    else
        rot_dif(pred_no)=90;
    end
end


end

