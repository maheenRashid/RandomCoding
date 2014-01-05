function [train_data,test_data]=whitenData(train_data,test_data)
train_data_x=train_data.X;

%whiten
[train_x_n_wh, train_x_n_mu, invMat, whMat] = whiten(train_data_x);
test_x_n_mu = mean(test_data.X);
test_x_n_wh=bsxfun(@minus,test_data.X,test_x_n_mu);
test_x_n_wh = test_x_n_wh*whMat;

train_data.X=train_x_n_wh;
test_data.X=test_x_n_wh;
end