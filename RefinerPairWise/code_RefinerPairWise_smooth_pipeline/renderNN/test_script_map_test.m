ccc

dir_parent='/lustre/maheenr/results_temp_09_13';
in_dir=['swapAllCombos_unique_3_gt_writeAndScoreLists_html'];

k=0.01;
path_nn=fullfile(dir_parent,in_dir,...
    ['results_' num2str(k) '_nn_LOO_ratioEqual']);
path_test_train=fullfile(dir_parent,in_dir,...
    'testTrainData_LOO_ratioEqual')

nn=load('b#bedroom#sun_aaajwnfblludyasb_nn');
% tt=load('b#bedroom#sun_aaajwnfblludyasb_test_train');
nn=nn.record_lists;
% tt=tt.record_lists;
nn
% tt

v_no=10;
[train_mo_no,list_no]=getListNoOfNN(nn,v_no,k);
return
train_vec=nn.feature_vecs_all(nn.train_idx);
train_idx=nn.train_idx;
train_idx=num2cell(train_idx);
train_pts=cellfun(@(x,y) y.*ones(size(x,1),1),train_vec,train_idx',...
    'UniformOutput',0);

% train_pts=cell(size(train_idx));
% for i=1:numel(train_idx)
%     train_pts{i}=train_idx{i}.*ones(size(train_vec{i},1),1);
% end
train_pts=cell2mat(train_pts);
topk=ceil(size(nn.det_scores_pred,2)*k);
idx_nn=nn.det_scores_idx(nn.best_list_idx_pred,1:topk);


det_scores_pred_top=nn.det_scores_pred(nn.best_list_idx_pred,1:topk);
det_scores_d_top=nn.det_scores_d(nn.best_list_idx_pred,1:topk);
weights=ones(size(det_scores_d_top))./det_scores_d_top;
weighted_scores=det_scores_pred_top.*weights;
[sort_w,sort_w_idx]=sort(weighted_scores);
idx_nn_sorted=idx_nn(sort_w_idx);


%visualize top 5 best neighbours
idx_nn_v_no=idx_nn_sorted(1:v_no);
%get train model_no
train_mo_no=train_pts(idx_nn_v_no);
%get list number for train_model_no
list_no=zeros(size(train_mo_no));
for i=1:numel(train_mo_no)
    idx_train=find(train_pts==train_mo_no(i));
    idx_train=find(idx_train==idx_nn_v_no(i));
    list_no(i)=idx_train;
end

test_vec=nn.feature_vecs_all{nn.test_idx};
test_vec=test_vec(nn.best_list_idx_pred,:);
train_vecs=cell(size(list_no));
for i=1:numel(train_vecs)
    train_vecs{i}=nn.feature_vecs_all{train_mo_no(i)}(list_no(i),:);
end

figure; subplot(v_no+1,1,1); imagesc(test_vec);
for i=1:numel(train_vecs)
    subplot(v_no+1,1,i+1);
    imagesc(train_vecs{i});
end

% test_pts{i}
% size(test_vec{1})
% size(test_vec)
