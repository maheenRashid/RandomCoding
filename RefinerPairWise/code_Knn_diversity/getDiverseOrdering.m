function [idx_rec,ssd_rec]=getDiverseOrdering(train_data,test)


train_pool_yet.X=zeros(0,size(train_data.X,2));
train_pool_yet.y=zeros(0,size(train_data.y,2));

train_pool_rest.X=train_data.X;
train_pool_rest.y=train_data.y;



ssd_rec=zeros(numel(train_pool_rest.y));
idx_rec=zeros(numel(train_pool_rest.y),1);
for train_no=1:numel(train_pool_rest.y)
    fprintf('train_no: %d\n', train_no);
    
%     tic()
    [idx_add,ssd]=getBestTrainToAdd(train_pool_yet,train_pool_rest,test);
%     toc()
    
    %record
    ssd_rec(1:numel(ssd),train_no)=ssd;
    idx_rec(train_no)=idx_add;
    
    %update train_pool_yet
    train_pool_yet.X=[train_pool_yet.X;train_pool_rest.X(idx_add,:)];
    train_pool_yet.y=[train_pool_yet.y;train_pool_rest.y(idx_add)];
    
    %update train_pool_rest
    train_pool_rest.X(idx_add,:)=[];
    train_pool_rest.y(idx_add,:)=[];
%     keyboard;
end

end