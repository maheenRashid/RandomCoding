function [val_danger,danger_idx]=getValDanger(record_lists,pred_idx,valid_idx)
train_idx=record_lists.train_idx;
train_f_cell=record_lists.feature_vecs_all(train_idx);
train_map=cellfun(@(x,y) ones(size(x,1),1)*y,train_f_cell(:),num2cell(train_idx(:)),'UniformOutput',0);
train_map=cell2mat(train_map);

size(record_lists.train_data.y);

idx=record_lists.det_scores_idx(pred_idx,:);

danger_idx=ismember(train_map,valid_idx);
danger_idx=find(danger_idx);

val_danger=ismember(idx,danger_idx);
val_danger=find(val_danger);
end