function [feature_vecs_all,det_scores_all]=getFeaturesAndReponse(dir_in,models,ratio)

feature_vecs_all=cell(numel(models),1);
det_scores_all=cell(1,numel(models));

for model_no=1:numel(models)
    load(fullfile(dir_in,models{model_no}));
    feature_vecs_all{model_no}=cell2mat(record_lists.feature_vecs')';
    
    %check if record_lists is dpm thresholded
    accu=record_lists.accuracy;
    
    if isfield(record_lists,'dpm_thresh_bin')
%         accu=record_lists.accuracy;
%         accu=accu(record_lists.lists_thresh_bin);
%         dpm_thresh_bin=record_lists.dpm_thresh_bin(2:end);
%         accu_prune=cellfun(@(x) x(dpm_thresh_bin,:),accu,'UniformOutput',0);
        accu=pruneAccuracyByThresh(record_lists);
    end
    
    det_scores_all{model_no}=cellfun(@(x) getDetScore(x,ratio),accu);
end

sizes=cellfun(@(x) size(x,2),feature_vecs_all);
max_size=max(sizes);
feature_vecs_all=cellfun(@(x) [x,zeros(size(x,1),max_size-size(x,2))],feature_vecs_all,'UniformOutput',0);

%normalize geometry score PER MODEL
% for i=1:numel(feature_vecs_all)
%     min_geo_score=min(feature_vecs_all{i}(:,1));
%     max_geo_score=max(feature_vecs_all{i}(:,1));
%     max_geo_score=max_geo_score-min_geo_score;
%     feature_vecs_all{i}(:,1)=(feature_vecs_all{i}(:,1)-min_geo_score)/max_geo_score;
% end

end