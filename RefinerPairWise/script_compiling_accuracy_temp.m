ccc
in_dir='results_accuracy_nn_ratioEqual';
mat_lists=dir(fullfile(in_dir,'*.mat'));


bsrs=zeros(2,numel(mat_lists));
other_accus_gt=zeros(3,numel(mat_lists));
other_accus_pred=zeros(3,numel(mat_lists));

for i=1:numel(mat_lists)
    load(fullfile(in_dir,mat_lists(i).name));
    [bsrs(1,i),other_accu_gt]=getBSR(record_accuracy.gt);
    [bsrs(2,i),other_accu_pred]=getBSR(record_accuracy.pred);
    other_accus_gt(:,i)=other_accu_gt;
    other_accus_pred(:,i)=other_accu_pred;
    
    
    
%     keyboard

end

avgs_gt=mean([bsrs(1,:);other_accus_gt],2);
avgs_pred=mean([bsrs(2,:);other_accus_pred],2);

[sort_val_pred,sort_idx_pred]=sort(bsrs(2,:));
[sort_val_gt,sort_idx_gt]=sort(bsrs(1,:));

figure;
plot(sort_val_gt,'-r');hold on;
plot(sort_val_pred,'-b');

figure;
plot(sort_val_pred,'-r');hold on;
plot(bsrs(1,sort_idx_pred),'-b');
title('sorted pred');


figure;
plot(sort_val_gt,'-r');hold on;
plot(bsrs(2,sort_idx_gt),'-b');
title('sorted gt');
legend('Best Hypothesis','NN Hypothesis');


figure;
bar([avgs_gt,avgs_pred]);
set(gca,'xticklabel',{'BSR','Negatives','Positives','Overall'});
legend('Best Hypothesis','NN Hypothesis');
title('Precision');
grid on;