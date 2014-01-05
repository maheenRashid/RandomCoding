function [prec_per_thresh,recall_per_thresh,number_per_thresh]=getPrecRecallPerThreshDpm(threshes,dpm_scores,dpm_bin,total_gt)
threshes=sort(threshes);
recall_per_thresh=zeros(1,numel(threshes));
prec_per_thresh=zeros(1,numel(threshes));
number_per_thresh=zeros(1,numel(threshes));
for thresh_no=1:numel(threshes)
    ratio_correct=zeros(2,numel(total_gt));
    ratio_correct(2,:)=cell2mat(total_gt);
    
    
    
    thresh=threshes(thresh_no);
    
    dpm_scores_t=cellfun(@(x) x(x>=thresh),dpm_scores,'UniformOutput',0);
    dpm_bin_t=cellfun(@(x,y) x(y>=thresh),dpm_bin,dpm_scores,'UniformOutput',0);
    empty_bin=cellfun(@isempty,dpm_bin_t);
    ratio_correct(:,empty_bin)=[];
    
    dpm_bin_t=dpm_bin_t(~empty_bin);
    
    prec_correct=zeros(2,numel(dpm_bin_t));
    prec_correct(2,:)=cellfun(@numel,dpm_bin_t);
    prec_correct(1,:)=cellfun(@(x) sum(x>0),dpm_bin_t);
    
%     keyboard;
    for dpm_bin_no=1:numel(dpm_bin_t)
        curr=dpm_bin_t{dpm_bin_no};
        curr=unique(curr);
        curr(curr==0)=[];
        ratio_correct(1,dpm_bin_no)=numel(curr);
    end
    
    recall_per_thresh(thresh_no)=sum(ratio_correct(1,:))/sum(ratio_correct(2,:));
    number_per_thresh(thresh_no)=sum(~empty_bin);
    prec_per_thresh(thresh_no)=sum(prec_correct(1,:))/sum(prec_correct(2,:));
    
%     correct_count=
end
end