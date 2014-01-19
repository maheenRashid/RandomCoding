ccc

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

[idx_rec,ssd_rec,ssd_ac,ssd_min_val]=getDiverseOrdering(train_data,test_data);

figure; plot(ssd_ac);title('performance');

figure; plot(ssd_min_val);title('ssd');
