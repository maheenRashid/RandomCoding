% function [record_pruned,idx]=getTopNFromFileStruct_UniqueScores(n,record)
     
ccc

load('temp_record');
n=10;


box_ids=record.box_ids;
pred_scores=record.pred_scores;

box_ids_unique=unique(box_ids);
idx=zeros(1,0);

for i=1:numel(box_ids_unique)

    idx_curr=find(box_ids==box_ids_unique(i));
    pred_scores_curr=pred_scores(idx_curr);
    [pred_scores_unique,i_u,i_o]=unique(pred_scores_curr);
    
    [pred_scores_sorted,sort_idx]=sort(pred_scores_unique,'descend');
    pred_scores_sorted(1)
    sort_idx=i_u(sort_idx);
    pred_scores_curr(sort_idx(1))
    
    n_curr=min(numel(sort_idx),n);
    idx=[idx;idx_curr(sort_idx(1:n_curr))];

end

record_pruned=record;
record_pruned.box_ids=record_pruned.box_ids(idx);
record_pruned.swap_info=record_pruned.swap_info(idx,:);
record_pruned.pred_scores=record_pruned.pred_scores(idx);
record_pruned.gt_scores=record_pruned.gt_scores(idx,:);


% end