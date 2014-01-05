ccc
load('testing_lin_reg.mat');

dets=zeros(1,numel(test_idx));
for i=1:numel(test_idx)
    svm_vecs_curr=[svm_vecs_all{test_idx(i)} ones(size(svm_vecs_all{test_idx(i)},1),1)];
    det_scores_curr=det_scores_all{test_idx(i)};
    y_hat=svm_vecs_curr*B;
    [~,max_idx]=max(y_hat);
    dets(1,i)=max(det_scores_curr);
    dets(2,i)=det_scores_curr(max_idx);
    
%     h=figure;
%     hold on;
%     plot(det_scores_curr,'*r');
%     plot(y_hat,'ob');
%     keyboard;
%     close(h);
end


return
ccc
addpath('../svm_files');
addpath('E:\RandomCoding\liblinear-1.93\windows');

load('testingLinReg_data.mat','svm_vecs_all','det_scores_all')

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
end

%create test/train data
n=numel(svm_vecs_all);
rand_idx = randperm(n);
test_idx=rand_idx(1:round(n/5));
train_idx=rand_idx(round(n/5)+1:end);
test_data.X = cell2mat(svm_vecs_all(test_idx));
test_data.y = cell2mat(det_scores_all(test_idx))';

train_data.X=cell2mat(svm_vecs_all(train_idx));
train_data.y=cell2mat(det_scores_all(train_idx))';

%scale data
[train_data, test_data, ~] = scaleSVM(train_data, test_data, train_data, 0, 1);

%concatenate ones for the constant term
train_data.X=[train_data.X, ones(size(train_data.X,1),1)];
test_data.X=[test_data.X, ones(size(test_data.X,1),1)];

%set up threshold of outliers.
thresh_out=1/100*numel(train_data.y);


%loop till we have very few outliers
max_iter=1000;
error=zeros(1,max_iter);
for loop_no=1:max_iter
    loop_no
    %linear regression
    [B,~,~,RINT] = regress(train_data.y,train_data.X);
    
    %look at mean squared error
    y_hat=test_data.X*B;
    error(loop_no)=sum((test_data.y-y_hat).^2)/numel(y_hat);
    fprintf('mean sq error on test: %d\n',  error(loop_no));
    fprintf('max error on test: %d\n',  max(abs(test_data.y-y_hat)));
    
    %detect outliers
    bin_outlier=RINT(:,1)<0;
    bin_outlier=bin_outlier & RINT(:,2)>0;
    bin_outlier=~bin_outlier;
    outlier_no=sum(bin_outlier);
    
    %if number of outliers is not too much, break
    if outlier_no<=thresh_out
        break
    end
    
    %remove outliers from train
    train_data.y(bin_outlier)=[];
    train_data.X(bin_outlier,:)=[];
    
end

%save for better analysis
save('testing_lin_reg.mat');


return

% train_data.y
% model = train( train_data.y,sparse(train_data.X), '-s 0');
% [predict_label, accuracy, dec_values] = predict(train_data.y,sparse(train_data.X), model); % test the training data


% [predict_label, accuracy, prob_estimates] = predict(heart_scale_label, heart_scale_inst, model, '-b 1');



%set up params
param.s = 3; 					% epsilon SVR
param.C = max(train_data.y) - min(train_data.y);	% FIX C based on Equation 9.61
param.t = 2; 					% RBF kernel
param.gset = 2.^[-7:7];				% range of the gamma parameter
param.eset = [0:5];				% range of the epsilon parameter
param.nfold = 2;				% 5-fold CV
cv_idx=crossvalind('Kfold',numel(train_data.y),2);

%do cross val
Rval = zeros(length(param.gset), length(param.eset));

for i = 1:param.nfold
    fprintf('i is %d\n',i);
    
    lrndata.X = train_data.X(cv_idx~=i,:);
    lrndata.y = train_data.y(cv_idx~=i,:);
    valdata.X = train_data.X(cv_idx==i,:);
    valdata.y = train_data.y(cv_idx==i,:);
    fprintf('lrndata.X size is %d\n',size(lrndata.X,1));
    %     keyboard;
    for j = 1:length(param.gset)
        fprintf('j is %d\n',j);
        param.g = param.gset(j);
        
        for k = 1:length(param.eset)
            fprintf('k is %d\n',k);
            param.e = param.eset(k);
            param.libsvm = ['-s ', num2str(param.s), ' -t ', num2str(param.t), ...
                ' -c ', num2str(param.C), ' -g ', num2str(param.g), ...
                ' -p ', num2str(param.e)];
            
            % build model on Learning data
            fprintf('training\n');
            tic()
            model = svmtrain(lrndata.y, sparse(lrndata.X), param.libsvm);
            toc()
            % predict on the validation data
            [y_hat, Acc, projection] = svmpredict(valdata.y, valdata.X, model);
            
            Rval(j,k) = Rval(j,k) + mean((y_hat-valdata.y).^2);
        end
    end
    
end

Rval = Rval ./ (param.nfold);
