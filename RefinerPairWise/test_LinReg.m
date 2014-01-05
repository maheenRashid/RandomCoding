ccc
addpath('../svm_files');
dir_in=fullfile('svm_trial_temp');
models=dir(fullfile(dir_in,'*.mat'));
models={models(:).name};
% models=models(1:15);
svm_vecs_all=cell(numel(models),1);
det_scores_all=cell(1,numel(models));

% ratio=[1,1];
labels=[0,1];

% get weights
% gt_cell=cell(numel(models),1);
% for model_no=1:numel(models)
%     load(fullfile(dir_in,models{model_no}));
%     gt_vec=cell2mat(record_lists.accuracy');
%     gt_vec=gt_vec(:,2);
%     gt_cell{model_no}=gt_vec;
% end

% ratio=getWeights(cell2mat(gt_cell),labels);
ratio=[0.5,0.5];

for model_no=1:numel(models)
    load(fullfile(dir_in,models{model_no}));
    svm_vecs_all{model_no}=cell2mat(record_lists.svm_vecs')';
    det_scores_all{model_no}=cellfun(@(x) getDetScore(x,ratio),record_lists.accuracy);
end

save('testingLinReg_data_ratioequal.mat','svm_vecs_all','det_scores_all')

