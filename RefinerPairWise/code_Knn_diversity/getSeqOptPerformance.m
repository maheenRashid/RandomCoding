function [perf_test,dist_test,perf_rand,dist_rand]=getSeqOptPerformance(record_lists,prct,valid_data_size)



count_train=numel(record_lists.train_idx);
count_valid=ceil(count_train*valid_data_size);


temp=randperm(count_train);
test_idx=record_lists.test_idx;
valid_idx=record_lists.train_idx(temp(1:count_valid));
train_idx=record_lists.train_idx(temp(count_valid+1:end));

[train_data,test_data]=getTrainTestData...
    (record_lists.feature_vecs_all,record_lists.det_scores_all,...
    test_idx,train_idx);


[train_data1,test_data]=whitenData(train_data,test_data);
[~,valid_data]=getTrainTestData...
    (record_lists.feature_vecs_all,record_lists.det_scores_all,...
    valid_idx,train_idx);
[~,valid_data]=whitenData(train_data,valid_data);

train_data=train_data1;

[idx_div,~,~]=getDiverseOrdering(train_data,valid_data);

idx_rand=randperm(numel(idx_div));
idx_rand=idx_div(idx_rand);


perf_test=zeros(1,numel(prct));
dist_test=zeros(1,numel(prct));
perf_rand=zeros(1,numel(prct));
dist_rand=zeros(1,numel(prct));

for i=1:numel(prct)
    train_curr=train_data;
    k=round(numel(idx_div)*prct(i));
    [perf_test(i),dist_test(i)]=getPerfDist(train_curr,test_data,idx_div,k);
    [perf_rand(i),dist_rand(i)]=getPerfDist(train_curr,test_data,idx_rand,k);
end





end

function [perf_test,dist_test]=getPerfDist(train_curr,test_data,idx_div,k)

train_curr.X=train_curr.X(idx_div(1:k),:);
train_curr.y=train_curr.y(idx_div(1:k));
[IDX,D]=knnsearch(train_curr.X,test_data.X);

gt_y=test_data.y;
pred_y=train_curr.y(IDX);

perf_test=sum((gt_y-pred_y).^2);
dist_test=sum(D);

end