function [ratio]=getWeightsForTraining(dir_in,models,labels)
    
% get weights
gt_cell=cell(numel(models),1);
for model_no=1:numel(models)
    load(fullfile(dir_in,models{model_no}));
    gt_vec=cell2mat(record_lists.accuracy');
    gt_vec=gt_vec(:,2);
    gt_cell{model_no}=gt_vec;
end

ratio=getWeights(cell2mat(gt_cell),labels);

end