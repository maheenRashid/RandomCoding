ccc

ndiv=load('b#bedroom#sun_aeeulfvrmtqcxgjs.mat');
div=load('b#bedroom#sun_aeeulfvrmtqcxgjs_div.mat');

valid_idx=div.record_lists.valid_idx;
ndiv_pred_idx=ndiv.record_lists.best_list_idx_pred;
div_pred_idx=div.record_lists.best_list_idx_pred;

%create train data model map

[val_danger_ndiv,danger_idx]=getValDanger(ndiv.record_lists,ndiv_pred_idx,valid_idx);
val_danger_div=getValDanger(ndiv.record_lists,div_pred_idx,valid_idx);

figure; hold on;
plot(val_danger_ndiv,'-b'); 
plot(val_danger_div,'-r')
legend('ndiv','div');

record_lists=ndiv.record_lists;
record_lists.train_data.X(danger_idx,:)=[];
record_lists.train_data.y(danger_idx)=[];

figure; imagesc(record_lists.det_scores_d);
figure; imagesc(record_lists.det_scores_idx);

bin=ismember(record_lists.det_scores_idx,danger_idx);
record_lists.det_scores_d=removeBin(record_lists.det_scores_d,bin,2);
record_lists.det_scores_pred=removeBin(record_lists.det_scores_pred,bin,2);

%get numel danger_idx
% x=numel(danger_idx);
% old_dim=size(record_lists.det_scores_idx);
% new_dim=[old_dim(1) old_dim(2)-x];
% idx_bin=find(bin);
% det_scores_d_vec=record_lists.det_scores_d(:);
% det_scores_d_vec(bin)=[];
% det_scores_d=reshape(det_scores_d_vec,new_dim);
% record_lists.det_scores_d=det_scores_d;
% record_lists.det_scores_pred(danger_idx)=[];

figure; imagesc(bin);
figure; imagesc(record_lists.det_scores_d);





k=0.1;
record_lists=getNNByPercentageK(record_lists,k)

record_lists.best_list_idx_pred