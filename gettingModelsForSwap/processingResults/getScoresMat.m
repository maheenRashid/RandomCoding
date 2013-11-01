
function [scores_mat]=getScoresMat(data)
    predscores_str=data(1:2:end);
    gt_scores_str=data(2:2:end);
    
    gt_scores_split=cellfun(@(x) regexpi(x,' ','split'),gt_scores_str,'UniformOutput',0);
    predscores_split=cellfun(@(x) regexpi(x,' ','split'),predscores_str,'UniformOutput',0);
    
    pred_mat=cellfun(@(x) str2double(x{end}),predscores_split);
    
    gt_mat=zeros(size(gt_scores_split,1),5);
    for i=1:size(gt_scores_split,2)
        idx=find(strcmp(gt_scores_split{i}(1,:),'GT_SCORE_all_px'));
%         keyboard;
        gt_mat(i,:)=cellfun(@str2double,gt_scores_split{i}(idx+1:2:end));
    end
    
    scores_mat=[pred_mat,gt_mat];
    
end

