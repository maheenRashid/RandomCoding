ccc
load('gt_list.mat');
gt_folds=zeros(1,numel(gt_list));
num_folds = 5;
  
for file_no=1:numel(gt_folds)
  gt_folds(file_no) = mod(string2hash(gt_list{file_no}), num_folds)+1;
end