function record_lists=getDistanceAllPoints(record_lists)
train_data=record_lists.train_data;
test_data=record_lists.test_data;
svm_vecs_curr=test_data.X;
det_scores_curr=test_data.y;
k_eff=size(train_data.X,1);
det_scores_pred=zeros(numel(det_scores_curr),k_eff);
det_scores_idx=zeros(numel(det_scores_curr),k_eff);
det_scores_d=zeros(numel(det_scores_curr),k_eff);
for check=1:size(svm_vecs_curr,1)
    [IDX,D] = knnsearch(sparse(train_data.X),...
        sparse(test_data.X(check,:)),'K',k_eff);
    det_scores_pred(check,:)=train_data.y(IDX);
    det_scores_idx(check,:)=IDX;
    det_scores_d(check,:)=D;
end
record_lists.det_scores_pred=det_scores_pred;
record_lists.det_scores_idx=det_scores_idx;
record_lists.det_scores_d=det_scores_d;
end