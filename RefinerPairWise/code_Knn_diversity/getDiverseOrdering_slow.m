function [idx_rec,ssd_rec,ssd_ac,ssd_min_val]=getDiverseOrdering(train_data,test)


train_pool_yet.X=zeros(0,size(train_data.X,2));
train_pool_yet.y=zeros(0,size(train_data.y,2));

train_pool_rest.X=train_data.X;
train_pool_rest.y=train_data.y;



ssd_rec=zeros(numel(train_pool_rest.y));
idx_rec=zeros(numel(train_pool_rest.y),1);
ssd_ac=zeros(1,numel(train_pool_rest.y));
ssd_min_val=zeros(1,numel(train_pool_rest.y));

for train_no=1:numel(train_pool_rest.y)
    fprintf('train_no: %d\n', train_no);
    
%     tic()
    [idx_add,ssd,min_val]=getBestTrainToAdd(train_pool_yet,train_pool_rest,test);
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
    
    ssd_min_val(train_no)=min_val;
    
    IDX=knnsearch(train_pool_yet.X,test.X);
    ssd_ac(train_no)=sum((train_pool_yet.y(IDX)-test.y).^2);
    
%     n_train=normc(train_pool_yet.y);
%     n_test=normc(test.y);
%     
%     figure;    
%     subplot(121);
%     
%     plot(train_pool_yet.y,'or');
%     hold on;
%     plot(test.y,'*b');
%     hold off;
%     
%     subplot(122);
%     
%     plot(n_train,'or');
%     hold on;
%     plot(n_test,'*b');
%     hold off;
%     pause;
%     close all;
end

end