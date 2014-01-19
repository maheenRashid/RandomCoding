function [feature_vecs_all,det_scores_all]=getFeaturesAndReponse_noOrder(dir_in,models,ratio)

feature_vecs_all=cell(numel(models),1);
det_scores_all=cell(1,numel(models));


for model_no=1:numel(models)
    load(fullfile(dir_in,models{model_no}));
    
    feature_vecs_all{model_no}=getFeatures_noOrder(record_lists);
    
    %check if record_lists is dpm thresholded
    accu=record_lists.accuracy;
    
    if isfield(record_lists,'dpm_thresh_bin')
        accu=pruneAccuracyByThresh(record_lists);
    end
    
    det_scores_all{model_no}=cellfun(@(x) getDetScore(x,ratio),accu);
end


sizes=cellfun(@(x) size(x,2),feature_vecs_all);
max_size=max(sizes);
feature_vecs_all=cellfun(@(x) [x,zeros(size(x,1),max_size-size(x,2))],...
    feature_vecs_all,'UniformOutput',0);




end


function [features_all]=getFeatures_noOrder(record_lists)
bin_occupied=record_lists.dpm_thresh_bin;
idx_occupied=find(bin_occupied(2:end));


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
    
    [cat_features_relevant]=getCatFeatures(cat_feature_curr,conf_feature_curr,idx_occupied,cat_nos);
    
    features_all(i,2:end)=cat_features_relevant;
    features_all(i,1)=conf_feature_curr(1);
    
end

features_all=removeUnusedDetections(features_all,record_lists.feature_vecs,cat_nos);



end

function features_all=removeUnusedDetections(features_all,feature_vecs,cat_nos)
problem_detections=cell2mat(feature_vecs')';
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
end


function [cat_features_relevant]=getCatFeatures(cat_feature_curr,conf_feature_curr,idx_occupied,cat_nos)

cat_features_reshape=reshape(cat_feature_curr,cat_nos,[]);
cat_features_relevant=cat_features_reshape(:,idx_occupied);

conf_relevant=conf_feature_curr(2:end);
conf_relevant=conf_relevant(idx_occupied)';
cat_features_relevant=cat_features_relevant...
    .*repmat(conf_relevant,size(cat_features_relevant,1),1);
cat_features_relevant=cat_features_relevant(:);
end