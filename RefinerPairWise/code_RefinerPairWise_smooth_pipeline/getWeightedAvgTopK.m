function [avg_pred_score]=getWeightedAvgTopK(det_scores_pred,det_scores_d,percentage)
    topk=ceil(size(det_scores_pred,2)*percentage);
    
    det_scores_pred_top=det_scores_pred(:,1:topk);
    det_scores_d_top=det_scores_d(:,1:topk);
    weights=ones(size(det_scores_d_top))./det_scores_d_top;
    weighted_scores=det_scores_pred_top.*weights;
    avg_pred_score=sum(weighted_scores,2)./sum(weights,2);
    
    
end