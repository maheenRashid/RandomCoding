ccc
dir_mat='dpm_accu_per_k_per_mod';



k_p_vec=0
% 0.01:0.01:0.1;
% cell_overall_accus=cell(2,numel(k_p_vec));
for k_p=k_p_vec
    if k_p==0
        str_k='linReg';
    else
        str_k=num2str(k_p);
    end
    load(fullfile(dir_mat,[str_k '_merged.mat']));

%     cell_overall_accus{1,k_p==k_p_vec}=record_accu.avgs_gt;
%     cell_overall_accus{2,k_p==k_p_vec}=record_accu.avgs_pred;
%     
%     figure;
%     plot(record_accu.sort_val_gt,'-r');hold on;
%     plot(record_accu.sort_val_pred,'-b');
%     hold off;
%     title(['sorted pred' num2str(k_p)]);
%     legend('Best Hypothesis','NN Hypothesis');
%     
%     figure;
%     plot(record_accu.sort_val_pred,'-r');hold on;
%     plot(record_accu.bsrs(1,record_accu.sort_idx_pred),'-b');
%     title(['sorted pred' num2str(k_p)]);
%     legend('Best Hypothesis','NN Hypothesis');
%     
%     figure;
%     plot(record_accu.sort_val_gt,'-r');hold on;
%     plot(record_accu.bsrs(2,record_accu.sort_idx_gt),'-b');
%     title(['sorted gt'  num2str(k_p)]);
%     legend('Best Hypothesis','NN Hypothesis');
    
    
    figure;
    bar([record_accu.avgs_gt,record_accu.avgs_pred]);
    set(gca,'xticklabel',{'BSR','Negatives','Positives','Overall'});
    legend('Best Hypothesis','NN Hypothesis');
    title(['Precision' num2str(k_p)]);
    grid on;
end