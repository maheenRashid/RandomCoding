ccc
load('b#bedroom#sun_aaajwnfblludyasb');

prct=0.05:0.05:1;
valid_data_size=0.05;
[perf_test,dist_test,perf_rand,dist_rand]=...
    getSeqOptPerformance(record_lists,prct,valid_data_size);

figure; subplot(211); plot(prct,dist_test);
subplot(212);plot(prct,perf_test);

figure; subplot(211); plot(prct,dist_rand);
subplot(212);plot(prct,perf_rand);


return
load('diverse_order');

figure; subplot(211);plot(dist); subplot(212);plot(perf);

prct=0.05:0.05:1;
perf_test=zeros(1,numel(prct));
dist_test=zeros(1,numel(prct));

figure;
for i=1:numel(prct)
    train_curr=train_data;
    k=round(numel(idx_div)*prct(i));
    train_curr.X=train_curr.X(idx_div(1:k),:);
    train_curr.y=train_curr.y(idx_div(1:k));
    [IDX,D]=knnsearch(train_curr.X,test_data.X);
    
    gt_y=test_data.y;
    pred_y=train_curr.y(IDX);
    
    perf_test(i)=sum((test_data.y-train_curr.y(IDX)).^2);
    dist_test(i)=sum(D);
    
    subplot(1,numel(prct),i)
    plot(pred_y,'or');hold on; plot(gt_y,'*b');
    
end

figure; subplot(211); plot(prct,dist_test);
subplot(212);plot(prct,perf_test);



return
addpath(fullfile('..','..','svm_files'));

load('b#bedroom#sun_aaajwnfblludyasb');

no_folds=5;

count_train=numel(record_lists.train_idx);
count_valid=ceil(count_train/no_folds);

temp=randperm(count_train);
test_idx=record_lists.test_idx;
valid_idx=record_lists.train_idx(temp(1:count_valid));
train_idx=record_lists.train_idx(temp(count_valid+1:end));

[train_data,test_data]=getTrainTestData...
            (record_lists.feature_vecs_all,record_lists.det_scores_all,...
            test_idx,train_idx);
        
[~,valid_data]=getTrainTestData...
            (record_lists.feature_vecs_all,record_lists.det_scores_all,...
            valid_idx,train_idx);

[train_data1,test_data]=whitenData(train_data,test_data);
[~,valid_data]=whitenData(train_data,valid_data);
train_data=train_data1;

% lim=500;
% train_data.X=train_data.X(1:lim,:);
% train_data.y=train_data.y(1:lim);

% [idx_div,dist,perf]=getDiverseOrdering(train_data,valid_data);


figure; subplot(211);plot(dist); subplot(212);plot(perf);



