ccc

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

tic();
[IDX,D]=knnsearch(train_data.X,valid_data.X,'K',size(train_data.X,1));
toc();

IDX_sort=zeros(size(IDX));
D_sort=zeros(size(IDX));
sort_idx=zeros(size(IDX));
for i=1:size(IDX,1)
    [IDX_sort(i,:),sort_idx(i,:)]=sort(IDX(i,:));
    D_sort(i,:)=D(i,sort_idx(i,:));
end

IDX=IDX_sort;
D=D_sort;

d_pool=zeros(size(D,1),0);
y_pool=zeros(0,1);

d_rest=D;
y_rest=train_data.y;

y_test=valid_data.y;
ssd_rec=zeros(size(d_rest,2),1);
idx_rec=zeros(size(d_rest,2),1);

d_min_yet=zeros(size(d_pool,1),0);

idx_min_yet=zeros(size(d_pool,1),1);

for i=1:size(d_rest,2)
%     if i>1
%         keyboard
%     end
    fprintf('i: %d\n',i);
    
    y_curr=[y_pool;0];
%     d_curr=[d_min_yet,
    d_curr=[d_pool,zeros(size(d_pool,1),1)];
    
%     fprintf('min\n');
%         tic()
%         
    ssd_rest=zeros(size(d_rest,2),1);
    for j=1:size(d_rest,2)
        d_curr(:,end)=d_rest(:,j);
        y_curr(end)=y_rest(j);
        [~,idx_curr]=min(d_curr,[],2);
        
        if i>1
            keyboard;
        end
        
        
            idx_actual=idx_curr;
%         if i~=1
%             idx_actual(idx_curr==1)=idx_min_yet(idx_curr==1);
%             idx_actual(idx_curr==2)=numel(y_curr);
%         end
        
        y_pred=y_curr(idx_actual);
        ssd_rest(j)=sum((y_pred-y_test).^2);
    
    end
%     toc()
    [min_ssd,min_idx]=min(ssd_rest);

    ssd_rec(i)=min_ssd;
    idx_rec(i)=min_idx;
    
%     fprintf('dpool\n');
%     tic()
    d_pool=[d_pool,d_rest(:,min_idx)];
    y_pool=[y_pool;y_rest(min_idx)];
%     toc()
    
%     fprintf('drest\n');
%     tic()
    d_rest(:,min_idx)=[];
    y_rest(min_idx)=[];
%     toc()
    
    [d_min_yet,idx_min_yet]=min(d_pool,[],2);
    
end


