function [accu,bsr,right_all]=getAccuracyStats_MultiCat(gt_box,pred_box,labs)

accu=sum(gt_box==pred_box)/numel(gt_box);
[bsr,right_all]=getBSR(pred_box,gt_box,labs);



end