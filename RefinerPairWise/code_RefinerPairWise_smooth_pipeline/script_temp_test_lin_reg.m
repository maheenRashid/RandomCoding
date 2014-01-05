ccc

load('b#bedroom#sun_aaajwnfblludyasb.mat');
X_train_c=[record_lists.train_data.X, ...
    ones(size(record_lists.train_data.X,1),1)];
X_test_c=[record_lists.test_data.X,ones(size(record_lists.test_data.X,1),1)];

[b,bint,r,rint,stats] = regress(record_lists.train_data.y,X_train_c);

y_pred= X_test_c*b;

figure; hold on;
plot(y_pred,'*r');
plot(record_lists.test_data.y,'ob');
[~,sort_idx]=sort(record_lists.test_data.y,'descend');
[~,sort_idx_pred]=sort(y_pred,'descend');

%find the group with the highest score
test_data_bin=X_test_c>0;
test_data_bin=test_data_bin(:,2:end-1);
[C,ia,ic] = unique(test_data_bin,'rows');

sum_scores=arrayfun(@(x) sum(y_pred(ic==x)),[1:size(C,1)]);
[~,max_idx]=max(sum_scores);
max_group=find(ic==max_idx);
plot(max_group,y_pred(max_group),'og');

best_list_idx_pred=getBestListIdx_geoScore(y_pred(max_group),record_lists.test_data.X(max_group,:));
best_list_idx_pred=max_group(best_list_idx_pred);

best_list_idx_gt=getBestListIdx_geoScore(record_lists.test_data.y,record_lists.test_data.X);
record_lists.best_list_idx_pred=best_list_idx_pred;
record_lists.best_list_idx_gt=best_list_idx_gt;


plot(best_list_idx_gt,record_lists.test_data.y(best_list_idx_gt),'*k');
plot(best_lists_idx_pred,record_lists.test_data.y(best_lists_idx_pred),'*m');
