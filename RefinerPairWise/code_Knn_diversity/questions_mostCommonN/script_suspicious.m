ccc

in_dir='testTrainData_LOO_ratioEqual_by_prec_withCat_0.10109_diversity_0.5';

models=dir(fullfile(in_dir,'*.mat'));

load(fullfile(in_dir,models(1).name),'record_lists');
% return
%is the train idx the same


feat_curr=record_lists.feature_vecs_all(record_lists.train_idx);
size_info=cellfun(@(x) size(x,1),feat_curr,'UniformOutput',0);
idx_info=num2cell(1:numel(feat_curr))';
train_model_map=cellfun(@(x,y) ones(x,1)*y,size_info,idx_info,'UniformOutput',0);
train_model_map=cell2mat(train_model_map);
train_model_map=train_model_map(record_lists.idx_div);
figure; imagesc(train_model_map);

cell_check=cell(numel(models),1);
for i=1:numel(models)
    x=load(fullfile(in_dir,models(i).name));
    cell_check{i}=x.record_lists.det_scores_idx;
end

cell_check_test=cellfun(@(x) train_model_map(x),cell_check,'UniformOutput',0);

cell_check_mat=cell2mat(cell_check_test);

figure; imagesc(cell_check_mat);



cell_check_map=cell2mat(cell_check);
figure; imagesc(cell_check_map);


sum_data=zeros(size(cell_check_map,2),1);
for i=1:size(cell_check_map,1)
    for j=1:size(cell_check_map,2)
        idx=cell_check_map(i,j);
        sum_data(idx)=sum_data(idx)+j;
    end
end

avg_data=sum_data/size(cell_check_map,2);
[sort_avg,sort_idx]=sort(avg_data);
figure; plot(sort_avg);

top_n=5;

idx_top=sort_idx(1:top_n);
idx_bottom=sort_idx(end-top_n+1:end);

temp=record_lists.train_data.X(sort_idx(1),:);
figure;imagesc(temp);
min(temp)
max(temp)

%histogram the top 500
idx_hist=cell_check_mat(:,1:500);
idx_hist=idx_hist(:);
hist(idx_hist,1:numel(feat_curr));
%yup. there's a bias
%wait why are all of these the least diverse? are they the least diverse or
%the most diverse
%look at code

% if they are the least diverse why are they being picked out from some
% images


%are they bedrooms or living rooms
models=record_lists.models_curr(record_lists.train_idx);
models=cellfun(@(x) regexpi(x,'#','split'),models,'UniformOutput',0);
models=cellfun(@(x) x{1},models,'UniformOutput',0);
bin_models=cell2mat(cellfun(@(x) x=='l',models,'UniformOutput',0));
figure; imagesc(bin_models);
%no.

%get their whitened norms



% feat_top=record_lists.train_data.X(idx_top,:);
% feat_bottom=record_lists.train_data.X(idx_bottom,:);
% figure; subplot(121); imagesc(feat_top);subplot(122);imagesc(feat_bottom);


%get feature vec bottom 10



%why is idx_div the same
% 
% mat_equal=zeros(numel(cell_check));
% for i=1:numel(cell_check)
%     a=cell_check{i};
%     for j=i+1:numel(cell_check)
%         b=cell_check{j};
%         mat_equal(i,j)=isequal(a,b);
%     end
% end
% 
% figure; imagesc(mat_equal);