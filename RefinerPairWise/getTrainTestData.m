function [train_data,test_data]=getTrainTestData(feature_vecs_all,det_scores_all,test_idx,train_idx,catOne)
if nargin<5
    catOne=0;
end

%create test/train data
test_data.X = cell2mat(feature_vecs_all(test_idx));
test_data.y = cell2mat(det_scores_all(test_idx))';
train_data.X=cell2mat(feature_vecs_all(train_idx));
train_data.y=cell2mat(det_scores_all(train_idx))';

%scale data
[train_data, test_data, ~] = scaleSVM(train_data, test_data, train_data, 0, 1);

%concatenate ones for the constant term
if catOne>0
train_data.X=[train_data.X, ones(size(train_data.X,1),1)];
test_data.X=[test_data.X, ones(size(test_data.X,1),1)];
end

end