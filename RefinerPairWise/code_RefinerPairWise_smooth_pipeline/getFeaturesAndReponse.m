function [feature_vecs_all,det_scores_all]=getFeaturesAndReponse(dir_in,models,ratio)

str_features={'feature_vecs'};

load(fullfile(dir_in,models{1}));
if isfield(record_lists,'cat_feature_vecs');
    str_features=[str_features, 'cat_feature_vecs'];
end



feature_vecs_all=cell(numel(models),numel(str_features));
det_scores_all=cell(1,numel(models));


for model_no=1:numel(models)
    load(fullfile(dir_in,models{model_no}));
   
    for str_no=1:numel(str_features)
        str_feature=str_features{str_no};
        str_to_eval=['cell2mat(record_lists.' str_feature ''')'''];
        feature_vecs_all{model_no,str_no}=eval(str_to_eval);
    end
    feature_vecs_bef=feature_vecs_all;
    %check if we need to apply lists thresh
    sizes=cellfun(@(x) size(x,1),feature_vecs_all(model_no,:),'UniformOutput',0);
    sizes=cell2mat(sizes);
    if numel(sizes)>1 && sum(sizes==sizes(1))~=numel(sizes)
        idx_problem_all=find(sizes~=sizes(1));
        for idx_problem=1:numel(idx_problem_all)
            idx_curr=idx_problem_all(idx_problem);
            feature_vecs_all{model_no,idx_curr}=...
            feature_vecs_all{model_no,idx_curr}(record_lists.lists_thresh_bin,:);
        end
    end
    
%     keyboard; 
    %check if record_lists is dpm thresholded
    accu=record_lists.accuracy;
    
    if isfield(record_lists,'dpm_thresh_bin')
        accu=pruneAccuracyByThresh(record_lists);
    end
    
    det_scores_all{model_no}=cellfun(@(x) getDetScore(x,ratio),accu);
end

for f_no=1:size(feature_vecs_all,2)
    sizes=cellfun(@(x) size(x,2),feature_vecs_all(:,f_no));
    max_size=max(sizes);
    feature_vecs_all(:,f_no)=cellfun(@(x) [x,zeros(size(x,1),max_size-size(x,2))],...
        feature_vecs_all(:,f_no),'UniformOutput',0);
end

if size(feature_vecs_all,2)>1
    temp=cell(size(feature_vecs_all,1),1);
    for i=1:size(feature_vecs_all,1)
        temp{i}=cell2mat(feature_vecs_all(i,:));
    end
    feature_vecs_all=temp;
end

end