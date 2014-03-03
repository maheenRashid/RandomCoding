function [record_to_return]=getSeqOptPerformance(record_lists,prct,valid_data_size,struct_flag)

if nargin<4
    struct_flag=0;
end

data_info=getDiversityInfo(record_lists,valid_data_size,prct);

if struct_flag==0
    %rand_performance struct
    record_to_return=getPerformanceComparisonStruct(data_info);
    record_to_return.valid_data_size=valid_data_size;
else
    %record_lists_structs
    record_to_return=setUpRecordLists(record_lists,data_info);
    %hack in case of dire times
    if numel(prct)==1
        record_to_return=record_to_return{1};
    end
end




end


function record_to_return=setUpRecordLists(record_lists,data_info)
prct=data_info.prct;
idx_div=data_info.idx_div;
record_to_return=cell(1,numel(prct));
record_lists=mergeStructs(record_lists,data_info);
for i=1:numel(prct)
    k=round(numel(idx_div)*prct(i));
    record_lists.train_data.X=data_info.train_data.X(idx_div(1:k),:);
    record_lists.train_data.y=data_info.train_data.y(idx_div(1:k),:);
    record_lists=getDistanceAllPoints(record_lists);
    record_lists.prct_curr=prct(i);
    record_to_return{i}=record_lists;
end
end

function [record_performance]=getPerformanceComparisonStruct(data_info)

idx_div=data_info.idx_div;
train_data=data_info.train_data;
test_data=data_info.test_data;
prct=data_info.prct;

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

record_performance=struct();
record_performance.perf_seq_opt=perf_test;
record_performance.dist_seq_opt=dist_test;
record_performance.dist_rand=dist_rand;
record_performance.perf_rand=perf_rand;
record_performance.prct_vec=prct;

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

function [data_info]=getProcessedData(record_lists,valid_data_size)

if valid_data_size>0
    count_train=numel(record_lists.train_idx);
    count_valid=ceil(count_train*valid_data_size);
    temp=randperm(count_train);
    test_idx=record_lists.test_idx;
    valid_idx=record_lists.train_idx(temp(1:count_valid));
    train_idx=record_lists.train_idx(temp(count_valid+1:end));
else
    test_idx=record_lists.test_idx;
    valid_idx=record_lists.valid_idx;
    train_idx=record_lists.train_idx;
end

[train_data,test_data]=getTrainTestData...
    (record_lists.feature_vecs_all,record_lists.det_scores_all,...
    test_idx,train_idx);


[train_data1,test_data]=whitenData(train_data,test_data);
[~,valid_data]=getTrainTestData...
    (record_lists.feature_vecs_all,record_lists.det_scores_all,...
    valid_idx,train_idx);
[~,valid_data]=whitenData(train_data,valid_data);

train_data=train_data1;

data_info=struct();
data_info.train_data=train_data;
data_info.test_data=test_data;
data_info.valid_data=valid_data;
data_info.train_idx=train_idx;
data_info.test_idx=test_idx;
data_info.valid_idx=valid_idx;

end

function data_info=getDiversityInfo(record_lists,valid_data_size,prct)
[data_info]=getProcessedData(record_lists,valid_data_size);
[idx_div,~,~]=getDiverseOrdering(data_info.train_data,data_info.valid_data);
data_info.idx_div=idx_div;
data_info.prct=prct;
end
