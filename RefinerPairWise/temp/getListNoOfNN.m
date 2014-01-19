function [train_mo_no,list_no]=getListNoOfNN(nn,v_no,k)

train_idx_feat_map=getTrainIdxFeatureMap(nn.train_idx,nn.feature_vecs_all(nn.train_idx));
[weighted_scores,topk]=getScoresNN(nn.det_scores_pred,nn.det_scores_d,nn.best_list_idx_pred,k);
idx_nn=getIdxTopNN(nn.det_scores_idx,nn.best_list_idx_pred,weighted_scores,topk,v_no);


train_mo_no=train_idx_feat_map(idx_nn);
list_no=zeros(size(train_mo_no));
for i=1:numel(train_mo_no)
    idx_train=find(train_idx_feat_map==train_mo_no(i));
    idx_train=find(idx_train==idx_nn(i));
    list_no(i)=idx_train;
end

end

function [train_idx_feat_map]=getTrainIdxFeatureMap(train_idx,train_features)
train_idx=num2cell(train_idx);
train_idx=train_idx';
train_idx_feat_map=cellfun(@(x,y) y.*ones(size(x,1),1),train_features,train_idx,...
    'UniformOutput',0);
train_idx_feat_map=cell2mat(train_idx_feat_map);

end

function [weighted_scores,topk]=getScoresNN(det_scores_pred,det_scores_d,best_list_idx_pred,k)
topk=ceil(size(det_scores_pred,2)*k);
det_scores_pred_top=det_scores_pred(best_list_idx_pred,1:topk);
det_scores_d_top=det_scores_d(best_list_idx_pred,1:topk);
weights=ones(size(det_scores_d_top))./det_scores_d_top;
weighted_scores=det_scores_pred_top.*weights;
end

function idx_nn=getIdxTopNN(det_scores_idx,best_list_idx_pred,weighted_scores,topk,v_no)
idx_nn=det_scores_idx(best_list_idx_pred,1:topk);
[~,sort_w_idx]=sort(weighted_scores,'descend');
idx_nn=idx_nn(sort_w_idx);
idx_nn=idx_nn(1:min(v_no,numel(idx_nn)));
end
