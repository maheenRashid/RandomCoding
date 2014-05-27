function [train_data,test_data]=getTrainTestDataWhitened_test(feature_vecs_all,det_scores_all,test_idx,train_idx)
test_data.X = cell2mat(feature_vecs_all(test_idx));
test_data.y = cell2mat(det_scores_all(test_idx))';
train_data.X=cell2mat(feature_vecs_all(train_idx));
train_data.y=cell2mat(det_scores_all(train_idx))';

if isempty(train_data.X)
    return
end

[train_data, test_data, ~] = scaleSVM(train_data, test_data, train_data, 0, 1);

% get rid of nans and infs
train_data.X(isnan(train_data.X))=0;
train_data.X(isinf(train_data.X))=1;


test_data.X(isnan(test_data.X))=0;
test_data.X(isinf(test_data.X))=1;


% [train_data.X W] = zca(train_data.X);
% test_data.X=test_data.X*W;

train_data_x=train_data.X;

%whiten
[train_x_n_wh, train_x_n_mu, invMat, whMat] = whiten(train_data_x);

%this is wrong
% test_x_n_mu = mean(test_data.X);
%this is right
test_x_n_mu = train_x_n_mu;

test_x_n_wh=bsxfun(@minus,test_data.X,test_x_n_mu);
test_x_n_wh = test_x_n_wh*whMat;

train_data.X=train_x_n_wh;
test_data.X=test_x_n_wh;




end

