% ccc

load('b#bedroom#sun_aaajwnfblludyasb');

% load(fullfile('..','code_RefinerPairWise_smooth_pipeline','record_dpm'));


train_data=record_lists.train_data;
test_data=record_lists.test_data;

train_data_x=train_data.X;
train_y=train_data.y;

%whiten
[train_x_n_wh, train_x_n_mu, invMat, whMat] = whiten(train_data_x);
test_x_n_mu = mean(test_data.X);
test_x_n_wh=bsxfun(@minus,test_data.X,test_x_n_mu);
test_x_n_wh = test_x_n_wh*whMat;


inc=20;

%setup getBestTrainToAdd

train_data.X=train_x_n_wh(1:inc:end,:);
train_data.y=train_y(1:inc:end,:);
test_data.X=test_x_n_wh;

% [idx_rec,ssd_rec]=getDiverseOrdering(train_data,test_data);

figure; plot(sum(ssd_rec,1));

ssd_rec_rand=zeros(size(ssd_rec));
rand_idx=randperm(numel(train_data.y));
train_data_rand=train_data;
train_data_rand.X=train_data_rand.X(rand_idx,:);
train_data_rand.y=train_data_rand.y(rand_idx,:);



train_pool_yet.X=zeros(0,size(train_data_rand.X,2));
train_pool_yet.y=zeros(0,size(train_data_rand.y,2));

train_pool_rest.X=train_data_rand.X;
train_pool_rest.y=train_data_rand.y;



for train_no=1:numel(train_pool_rest.y)
    fprintf('train_no: %d\n', train_no);
    
%     tic()
    [~,ssd]=getBestTrainToAdd(train_pool_yet,train_pool_rest,test_data);
%     toc()
    
    %record
    ssd_rec_rand(1:numel(ssd),train_no)=ssd;
%     idx_rec(train_no)=idx_add;
    
    %update train_pool_yet
    train_pool_yet.X=[train_pool_yet.X;train_pool_rest.X(1,:)];
    train_pool_yet.y=[train_pool_yet.y;train_pool_rest.y(1)];
    
    %update train_pool_rest
    train_pool_rest.X(1,:)=[];
    train_pool_rest.y(1,:)=[];
%     keyboard;
end
figure; plot(sum(ssd_rec_rand,1));