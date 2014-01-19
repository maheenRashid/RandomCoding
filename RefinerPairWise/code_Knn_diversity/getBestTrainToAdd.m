function [idx_add,ssd,min_val]=getBestTrainToAdd(train_pool_yet,train_pool_rest,test)
test_x=test.X;
test_y=test.y;

train_pool_x=train_pool_yet.X;
train_pool_y=train_pool_yet.y;

train_rest_x=train_pool_rest.X;
train_rest_y=train_pool_rest.y;

train_y_curr=[train_pool_y;0];
train_x_curr=[train_pool_x;zeros(1,size(train_pool_x,2))];
ssd=zeros(size(train_rest_y));




for train_add_no=1:numel(train_rest_y)
    train_y_curr(end,:)=train_rest_y(train_add_no);
    train_x_curr(end,:)=train_rest_x(train_add_no,:);
    
%     sd=zeros(size(test_y));
    [IDX,D]=knnsearch(train_x_curr,test_x);
    ssd(train_add_no)=sum(D);
    
%     pred=train_y_curr(IDX);
%     pred=normc(pred);
%     gt=normc(test_y);
%     
%     ssd(train_add_no)=sum((pred-gt).^2);
    
end

[min_val,idx_add]=min(ssd);


end