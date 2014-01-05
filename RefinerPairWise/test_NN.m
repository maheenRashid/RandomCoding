% ccc
% load('temp_knn.mat');
%
% det_scores_pred=det_scores_pred(1:50);
% det_scores_curr=det_scores_curr(1:50);
%
% uni_scores=unique(det_scores_pred);
% max_score=min(uni_scores);
% idx_max=find(det_scores_pred==max_score);
% det_scores_max_gt=det_scores_curr(idx_max);
% svm_vecs_max=svm_vecs_curr(idx_max,:);
% [~,idx]=max(svm_vecs_max(:,1));
%
%
%
%
% return
% ccc
% 
% load('temp_ridge.mat');
% train_data.X=normr(train_data.X);
% test_data.X=normr(test_data.X);

% return

% tic()
% NS = KDTreeSearcher(train_data.X);
% toc()

for test_no=1:numel(test_idx)
    svm_vecs_curr=test_data.X(test_idx_mat==test_idx(test_no),:);
    
    splits=linspace(1,size(svm_vecs_curr,1),1000);
    
    %     svm_vecs_curr=svm_vecs_curr(1:50,:);
    det_scores_curr=det_scores_all{test_idx(test_no)};
    det_scores_pred=zeros(size(det_scores_curr));
    det_scores_idx=det_scores_pred;
    size(svm_vecs_curr)
    %     pause;
    %     for check=1:size(svm_vecs_curr,1)
    for i=1:size(svm_vecs_curr,1)
        curr_interval=i;
%         splits(i):splits(i+1);
%         check
        size(curr_interval)
        tic()
        IDX = knnsearch(sparse(train_data.X),sparse(svm_vecs_curr(curr_interval,:)));
        toc()
        det_scores_pred(curr_interval)=train_data.y(IDX);
        det_scores_idx(curr_interval)=IDX;
        return
    end
    return
end