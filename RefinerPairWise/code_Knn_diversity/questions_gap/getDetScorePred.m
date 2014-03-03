function score=getDetScorePred(record_lists)
best_list_idx_pred=record_lists.best_list_idx_pred;
score=record_lists.test_data.y(best_list_idx_pred);

end