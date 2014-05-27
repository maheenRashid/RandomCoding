function [features_all,det_scores_all,error_files]=getFeaturesAndReponse_noOrder(dir_in,models,ratio)

    [features_all_struct,error_files]=getFeaturesStruct(dir_in,models,ratio);
    
    features_all={features_all_struct(:).features_all};
    empties=cellfun(@isempty,features_all);
    
    to_deal=zeros(1,0);
    det_scores_all={features_all_struct(:).det_scores_all};
    det_scores_all(empties)={to_deal};
    
    sizes=cellfun(@(x) size(x,2),features_all);
    max_size=max(sizes);
    features_all=cellfun(@(x) [x,zeros(size(x,1),max_size-size(x,2))],...
        features_all,'UniformOutput',0);
    features_all=features_all';
    

end


function [features_all_struct,error_files]=getFeaturesStruct(dir_in,models,ratio)

dummy=cell(size(models));
features_all_struct=struct('features_all',dummy,'det_scores_all',dummy);
error_files=cell(size(models));

matlabpool open;
parfor i=1:numel(models)
%     fprintf('%d\n',i);
    try
        temp=load(fullfile(dir_in,models{i}));
        record_lists=temp.record_lists;
        features_all_struct(i).features_all=...
            getFeatures_noOrder(record_lists);
        
        accu=record_lists.accuracy;
        if isfield(record_lists,'dpm_thresh_bin')
            accu=pruneAccuracyByThresh(record_lists);
        end
        features_all_struct(i).det_scores_all=cellfun(@(x) getDetScore(x,ratio),accu);
        
    catch err
        fprintf('error\n');
        error_files{i}=err.identifier;
    end
end
matlabpool close;

end

function [features_all]=getFeatures_noOrder(record_lists)
bin_occupied=record_lists.dpm_thresh_bin;
% idx_occupied=find(bin_occupied(2:end));
idx_occupied=1:sum(bin_occupied(2:end));

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
features_all=sparse(features_all);


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