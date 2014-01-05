ccc

dir_parent='/home/maheenr/results_temp_09_13';
folder='swapAllCombos_unique_10_gt_writeAndScoreLists';

dir_dpm_bin=fullfile(dir_parent,[folder '_html'],'record_lists_dpm_bin');

ratio=[1,11];

models=dir(fullfile(dir_dpm_bin,'*.mat'));
models={models(:).name};
models=cellfun(@(x) x(1:end-4),models,'UniformOutput',0);

scores=cell(1,numel(models));
det_scores=cell(1,numel(models));
bsrs=cell(1,numel(models));

for model_no=1:60
%     numel(models)
    model_no
    load(fullfile(dir_dpm_bin,[models{model_no} '.mat']));
    pred_score=cell2mat(record_lists.scores');
    dpm_score=record_lists.dpm_scores;
    det_score=cellfun(@(x) getDetScore(x,ratio),record_lists.accuracy);
    dpm_scores=cellfun(@(x) dpm_score'*x(:,3),record_lists.accuracy);
    
    record_lists.both_scores=[dpm_scores;pred_score];
    record_lists.det_score=det_score;
    record_lists.bsrs=cellfun(@(x) getBSR(x),record_lists.accuracy);
    
    scores{model_no}=[dpm_scores;pred_score];
    det_scores{model_no}=det_score;
    bsrs{model_no}=record_lists.bsrs;
end

scores_mat=cell2mat(scores);
det_score_mat=cell2mat(det_scores);

weights_init=[1;1];
options=optimset( 'Display', 'iter', 'MaxIter', 2000, 'TolFun', 10^-20000, 'TolX', 10^-10,'MaxFunEvals',10^20);
weights_final = lsqcurvefit(@(x,y) x'*y,weights_init,scores_mat,det_score_mat,[],[],options);

save('lets_visualizes.mat','weights_final','bsrs','det_scores','scores');


% for i=1:60
%     load(fullfile(dir_dpm_bin,[models{model_no} '.mat']));
%     det_score_pred=weights_final'*record_lists.both_scores;
%     [det_score_pred_sort,sort_idx_pred]=sort(det_score_pred,'descend');
%     bsr_pred=record_lists.bsrs(sort_idx_pred);
%     [det_score_sort,sort_idx]=sort(record_lists.det_score,'descend');
%     bsr_gt=record_lists.bsr(sort_idx);
%     
% end