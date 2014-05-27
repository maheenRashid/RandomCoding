function [train_data,test_data]=getTrainTestDataWhitened(feature_vecs_all,det_scores_all,test_idx,train_idx)
test_data.X = cell2mat(feature_vecs_all(test_idx));
test_data.y = cell2mat(det_scores_all(test_idx))';
train_data.X=cell2mat(feature_vecs_all(train_idx));
train_data.y=cell2mat(det_scores_all(train_idx))';

if isempty(train_data.X)
    return
end

[train_data.X W] = zca(train_data.X);
test_data.X=test_data.X*W;



end

