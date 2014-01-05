ccc

load('b#bedroom#sun_aaajwnfblludyasb');

% load(fullfile('..','code_RefinerPairWise_smooth_pipeline','record_dpm'));


train_data=record_lists.train_data;
test_data=record_lists.test_data;

total=size(train_data.X,1);
valid_no=ceil(total/5);
train_idx=randperm(total);
valid_idx=train_idx(1:valid_no-1);
train_idx=train_idx(valid_no:end);

train_data_x=train_data.X(train_idx,:);
valid_data_x=train_data.X(valid_idx,:);

valid_y=train_data.y(valid_idx);
train_y=train_data.y(train_idx);

[train_x_n_wh, train_x_n_mu, invMat, whMat] = whiten(train_data_x);
test_x_n_mu = mean(test_data.X);
test_x_n_wh=bsxfun(@minus,test_data.X,test_x_n_mu);
test_x_n_wh = test_x_n_wh*whMat;

valid_x_n_mu = mean(valid_data_x);
valid_x_n_wh=bsxfun(@minus,valid_data_x,valid_x_n_mu);
valid_x_n_wh = valid_x_n_wh*whMat;




inc=1;

train_x_n_wh=train_x_n_wh(1:1000,:);
train_y=train_y(1:1000);


size_train=size(train_x_n_wh,1);

train_pool_yet=zeros(0,size(train_x_n_wh,2));
train_y_yet=zeros(0,1);
train_pool_rest=train_x_n_wh;
train_y_rest=train_y;


idx_add=1:inc:size_train;
idx_add(end)=size_train;


ssd=zeros(numel(idx_add)-1);

for j=1:numel(ssd)
    ssd_inner=zeros(numel(idx_add)-1,1);
    
    for i=1:numel(idx_add)-1
        
        train_data_curr=[train_pool_yet;...
            train_x_n_wh(idx_add(i):idx_add(i+1),:)];
        train_y_curr=[train_y_yet;...
            train_y_rest(idx_add(i):idx_add(i+1),:)];
        [IDX,D] = knnsearch(train_data_curr,valid_x_n_wh);
        valid_pred_curr=train_y_curr(IDX);
        ssd_inner(i)=sum((valid_pred_curr-valid_y).^2);
        
    end
    [min_ssd,min_idx]=min(ssd_inner);
    idx_to_add=idx_add(min_idx):idx_add(min_idx+1);
    
    train_y_yet=[train_y_yet;...
        train_y_rest(idx_to_add,:)];
    train_pool_yet=[train_pool_yet;...
        train_pool_rest(idx_to_add,:)];
    
    train_pool_rest(idx_to_add,:)=[];
    train_y_rest(idx_to_add,:)=[];
    
    idx_add=1:inc:numel(train_y_rest);
    if numel(idx_add)==1
        idx_add=[idx_add, idx_add];
    end
    idx_add(end)=numel(train_y_rest);

    
    ssd(j)=min_ssd;
end




% figure;
% imagesc(record_lists.det_scores_pred);
% figure;
% imagesc(repmat(test_data.y,1,size(train_data.X,1)))


% [COEFF,SCORE,latent,tsquare] = princomp(train_x_n_wh);