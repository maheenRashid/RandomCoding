ccc 
load('gt_list.mat')
 
 
 
 gt_fold_idx=cell(1,numel(gt_list));
 
 for gt_no=1:numel(gt_list)
    gt_no
    fold=gt_folds(gt_no);
    folds_other=gt_folds==fold;
    folds_other=find(folds_other);
    folds_other(folds_other==gt_no)=[];
    gt_fold_idx{gt_no}=folds_other;
%     keyboard;
 end
 
 save('gt_list.mat')
 