ccc

load l#living_room#sun_aykkdobyhjevkiib.mat

% record_lists = 
% 
%        idx_on_ground: [0 1 2 3 4 5 6 7 8 10 11 12 13 14 15 16 17 18 19 20]
%              box_nos: [1x200 double]
%              cat_nos: [23x1 double]
%              box_dim: [20x6 double]
%               scores: {43x1 cell}
%                lists: {43x1 cell}
%             accuracy: {1x43 cell}
%           dpm_scores: [23x1 double]
%         feature_vecs: {4x1 cell}
%     cat_feature_vecs: {43x1 cell}
%     feature_vecs_all: {43x1 cell}
%       dpm_thresh_bin: [24x1 logical]
%     lists_thresh_bin: [43x1 logical]

% for i=1:numel(record_lists.feature_vecs)
%      conf_feature_curr=record_lists.feature_vecs{i};
%     conf_feature_curr=[conf_feature_curr(1:2); 0;conf_feature_curr(3:end);0];
%     record_lists.feature_vecs{i}=conf_feature_curr;
%    
% end


bin_occupied=record_lists.dpm_thresh_bin;
idx_occupied=find(bin_occupied(2:end));
% idx_occupied=[idx_occupied;4;5];


list_idx=find(record_lists.lists_thresh_bin);
if isempty(list_idx)
    features_all=[];
    return
end

cat_nos=numel(record_lists.cat_feature_vecs{1})/(numel(record_lists.feature_vecs_all{1})-1);
size_f_vec=cat_nos*(numel(record_lists.feature_vecs{1})-1)+1;
features_all=zeros(numel(record_lists.feature_vecs),size_f_vec);

for i=1:numel(list_idx)
    idx=list_idx(i);
    cat_feature_curr=record_lists.cat_feature_vecs{idx};
    conf_feature_curr=record_lists.feature_vecs{i};
    
    cat_features_reshape=cat_feature_curr;
    cat_features_reshape=reshape(cat_features_reshape,cat_nos,[]);
    cat_features_relevant=cat_features_reshape(:,idx_occupied);

    conf_relevant=conf_feature_curr(2:end);
    conf_relevant=conf_relevant(idx_occupied)';
    cat_features_relevant=cat_features_relevant...
        .*repmat(conf_relevant,size(cat_features_relevant,1),1);
    
    features_all(i,2:end)=cat_features_relevant(:);
    features_all(i,1)=conf_feature_curr(1);
    
end

problem_detections=cell2mat(record_lists.feature_vecs')';
problem_detections=sum(problem_detections,1)==0;
problem_detections=find(problem_detections(2:end));

idx_to_rem=zeros(1,0);
for i=1:numel(problem_detections)
    idx_curr=problem_detections(i);
    begin_idx=cat_nos*(idx_curr-1)+2;
    end_idx=begin_idx+cat_nos-1;
    idx_to_rem=[idx_to_rem,begin_idx:end_idx];

end

features_all(:,idx_to_rem)=[];


% bin_check=sum(features_all,1);
% bin_check=bin_check==0;
% features_all(:,bin_check)=[];
% 
% features_all

size(record_lists.feature_vecs)
sum(record_lists.lists_thresh_bin)
