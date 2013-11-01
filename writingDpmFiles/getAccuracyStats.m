function [accu,bsr,one_right,zeros_right]=getAccuracyStats(gt_box,pred_box)

accu=sum(gt_box==pred_box)/numel(gt_box);
one_right=sum(pred_box==1 & gt_box==1)/sum(gt_box==1);
if isnan(one_right)
    keyboard
    one_right=0;
end
zeros_right=sum(pred_box==0 & gt_box==0)/sum(gt_box==0);
if isnan(zeros_right)
    keyboard
    zeros_right=0;
end
bsr=(one_right+zeros_right)/2;


end