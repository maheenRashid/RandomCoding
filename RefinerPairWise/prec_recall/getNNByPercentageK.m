function record_lists=getNNByPercentageK(record_lists,k)


test_data=record_lists.test_data;
svm_vecs_curr=test_data.X;
det_scores_curr=test_data.y;
best_list_idx_gt=getBestListIdx_geoScore(det_scores_curr,svm_vecs_curr);
det_scores_pred=record_lists.det_scores_pred;
det_scores_d=record_lists.det_scores_d;
[avg_pred_score]=getWeightedAvgTopK(det_scores_pred,det_scores_d,k);
best_list_idx_pred=getBestListIdx_geoScore(avg_pred_score,svm_vecs_curr);
record_lists.best_list_idx_pred=best_list_idx_pred;
record_lists.best_list_idx_gt=best_list_idx_gt;

end