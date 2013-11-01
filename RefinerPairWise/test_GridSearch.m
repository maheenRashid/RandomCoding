ccc

ratio=[1,11];
load('record_lists_accu.mat');

% detections_all={record_lists(:).accuracy};
% pred_scores_all={record_lists(:).scores};
% dpm_scores_all={record_lists(:).dpm_scores};

for i=1:numel(record_lists)
    pred_score=cell2mat(record_lists(i).scores');
    dpm_score=record_lists(i).dpm_scores;
    det_score=cellfun(@(x) getDetScore(x,ratio),record_lists(i).accuracy);
    dpm_scores=cellfun(@(x) dpm_score'*x(:,3),record_lists(i).accuracy);
    
    record_lists(i).both_scores=[dpm_scores;pred_score];
    record_lists(i).det_score=det_score;
    
end


scores=cell2mat({record_lists(:).both_scores});
det_score=cell2mat({record_lists(:).det_score});

weights_init=[1;1];
options=optimset( 'Display', 'iter', 'MaxIter', 2000, 'TolFun', 10^-20000, 'TolX', 10^-10,'MaxFunEvals',10^20);
weights_final = lsqcurvefit(@(x,y) x'*y,weights_init,scores,det_score,[],[],options);


% return
% 
% 
% options=optimset( 'Display', 'iter', 'MaxIter', 2000, 'TolFun', 10^-20000, 'TolX', 10^-10,'MaxFunEvals',10^20);
% %     weights_final = fminsearch(@findBestWeights,weights_init,options,scores,det_score);
%     
%     weights_final = fminunc(@findBestWeights_Order,weights_init,options,scores,det_score_idx);
    
    for i=1:numel(record_lists)
        det_score_pred=weights_final'*record_lists(i).both_scores;
        [det_score_pred_sort,sort_idx_pred]=sort(det_score_pred,'descend');
        accuracy_pred=record_lists(i).accuracy(sort_idx_pred);
        [det_score_sort,sort_idx]=sort(record_lists(i).det_score,'descend');
        accuracy_gt=record_lists(i).accuracy(sort_idx);
        eg_accu_pred=accuracy_pred{1}
        eg_accu_gt=accuracy_gt{1}
        keyboard
    
    end