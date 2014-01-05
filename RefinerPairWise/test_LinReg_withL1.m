% ccc
% load('temp_ridge.mat');
% 
% dets=cell(1,numel(test_idx));
% for i=1:numel(test_idx)
%     svm_vecs_curr=test_data.X(test_idx_mat==test_idx(i),:);
%     svm_vecs_curr=[ones(size(svm_vecs_curr,1),1) svm_vecs_curr ];
%     det_scores_curr=det_scores_all{test_idx(i)};
%     y_hat=svm_vecs_curr*b;
%     dets_curr=[det_scores_curr;y_hat'];
%     dets{i}=dets_curr;
% %     h=figure;
% %     hold on;
% %     plot(det_scores_curr,'*r');
% %     plot(y_hat,'ob');
% %     keyboard;
% %     close(h);
% end
% 
% 
% save('temp_ridge.mat');
% 
% return
ccc
addpath('../svm_files');
addpath('E:\RandomCoding\liblinear-1.93\windows');

load('testingLinReg_data_ratioequal.mat','svm_vecs_all','det_scores_all')
% return
%set up the X size
sizes=cellfun(@(x) size(x,2),svm_vecs_all);
max_size=max(sizes);
svm_vecs_all=cellfun(@(x) [x,zeros(size(x,1),max_size-size(x,2))],svm_vecs_all,'UniformOutput',0);

%normalize geometry score PER MODEL
for i=1:numel(svm_vecs_all)
    min_geo_score=min(svm_vecs_all{i}(:,1));
    max_geo_score=max(svm_vecs_all{i}(:,1));
    max_geo_score=max_geo_score-min_geo_score;
    svm_vecs_all{i}(:,1)=(svm_vecs_all{i}(:,1)-min_geo_score)/max_geo_score;
    %     det_scores_all{i}=det_scores_all{i}+svm_vecs_all{i}(:,1)';
end

%create test/train data
n=numel(svm_vecs_all);
% rand_idx = randperm(n);
% test_idx=rand_idx(1:round(n/5));
% train_idx=rand_idx(round(n/5)+1:end);
test_idx=1:5:numel(svm_vecs_all);
train_idx=1:numel(svm_vecs_all);
train_idx(test_idx)=[];

test_data.X = cell2mat(svm_vecs_all(test_idx));
test_data.y = cell2mat(det_scores_all(test_idx))';

test_idx_cell=num2cell(test_idx);
test_idx_mat=cell2mat(cellfun(@(x,y) y*ones(size(x)),det_scores_all(test_idx),test_idx_cell,'UniformOutput',0));

train_data.X=cell2mat(svm_vecs_all(train_idx));
train_data.y=cell2mat(det_scores_all(train_idx))';

%scale data
[train_data, test_data, ~] = scaleSVM(train_data, test_data, train_data, 0, 1);

%concatenate ones for the constant term
% train_data.X=[train_data.X, ones(size(train_data.X,1),1)];
% test_data.X=[test_data.X, ones(size(test_data.X,1),1)];
% load('temp.mat','train_data');

k = 0;
% :0.1:1;

% N=size(train_data.X,1);
% X = [ones(N,1),train_data.X];
%
% b_ridge=zeros(size(X,2),numel(k));
% for lambda_no=1:numel(k)
%     lambda=k(lambda_no);
% % R = X'*X + lambda*diag(var(X));
% R = X'*X + lambda*eye(size(X,2));
% % Rinv = inv(R);
% b_ridge(:,lambda_no) = R\X'*train_data.y;
% end
% % y_ridge = X*b_ridge;
% %
% train_data.X(train_data.X==0)=nan;

b = lasso(train_data.X,train_data.y,'CV',2);

% b = ridge(train_data.y,train_data.X,k,0);
figure
plot(b,'LineWidth',2)
save('temp_lasso.mat');

