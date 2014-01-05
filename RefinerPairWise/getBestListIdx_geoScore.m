function [best_list_idx]=getBestListIdx_geoScore(det_scores_pred,svm_vecs_curr)
    
    uni_scores=unique(det_scores_pred);
    max_score=max(uni_scores);
    idx_max=find(det_scores_pred==max_score);
    svm_vecs_max=svm_vecs_curr(idx_max,:);
    [~,idx]=max(svm_vecs_max(:,1));
    best_list_idx=idx_max(idx);


end