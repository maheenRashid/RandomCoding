
linRegFlag=0;
in_dir=['swapAllCombos_unique_' num2str(n) '_' folder_type{folder_no} ...
    '_writeAndScoreLists_html'];


if k_p_vec==0
    k_p_vec=1;
    linRegFlag=1;
    str_k='linReg';
end

dir_accu=fullfile(dir_parent,in_dir,'dpm_accu_per_k_per_mod');
out_dir=dir_accu;

for k_p=k_p_vec
    if linRegFlag==0
        str_k=num2str(k_p);
    end
    dir_accu_curr=fullfile(dir_accu,str_k);
    mat_lists=dir(fullfile(dir_accu_curr,'*.mat'));
    
    
    bsrs=zeros(2,numel(mat_lists));
    other_accus_gt=zeros(3,numel(mat_lists));
    other_accus_pred=zeros(3,numel(mat_lists));
    
    for i=1:numel(mat_lists)
        load(fullfile(dir_accu_curr,mat_lists(i).name));
        [bsrs(1,i),other_accu_gt]=getBSR(record_accuracy.gt);
        [bsrs(2,i),other_accu_pred]=getBSR(record_accuracy.pred);
        other_accus_gt(:,i)=other_accu_gt;
        other_accus_pred(:,i)=other_accu_pred;
        
    end
    avgs_gt=mean([bsrs(1,:);other_accus_gt],2);
    avgs_pred=mean([bsrs(2,:);other_accus_pred],2);
    
    [sort_val_pred,sort_idx_pred]=sort(bsrs(2,:));
    [sort_val_gt,sort_idx_gt]=sort(bsrs(1,:));
    
    record_accu=struct();
    record_accu.bsrs=bsrs;
    record_accu.other_accus_gt=other_accus_gt;
    record_accu.other_accus_pred=other_accus_pred;
    record_accu.avgs_gt=avgs_gt;
    record_accu.avgs_pred=avgs_pred;
    record_accu.sort_val_pred=sort_val_pred;
    record_accu.sort_val_gt=sort_val_gt;
    record_accu.sort_idx_pred=sort_idx_pred;
    record_accu.sort_idx_gt=sort_idx_gt;
    
    out_file_name=fullfile(out_dir,[str_k '_merged.mat']);
    save(out_file_name,'record_accu');
    
    
end