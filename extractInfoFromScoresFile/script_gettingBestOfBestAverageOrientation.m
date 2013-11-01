ccc

fid=fopen(fullfile('b#bedroom#sun_aaajwnfblludyasb','scores_and_offsets.txt'));
data=textscan(fid,'%s','delimiter','\n');
fclose(fid);
data=data{1};

pred_score_org=data{2};
pred_score_org=regexpi(pred_score_org,' ','split');
pred_score_org=str2double(pred_score_org{end});

data=data(4:end);
[box_ids,swap_info,pred_scores,gt_scores]=getSwapAndScoreInfoAll(data);
% scores_all=[pred_scores,gt_scores];

box_u=unique(box_ids,'stable');
rot_u=unique(swap_info(:,4),'stable');
bestRot=zeros(size(box_u));

bestSwapsAvg=zeros(numel(box_u),size(swap_info,2));
bestScoresAvg=zeros(numel(box_u),6);
for box_no=1:numel(box_u)
    averages=zeros(size(rot_u,1),6);
    swap_avg_best=zeros(size(rot_u,1),5);
    score_avg_best=zeros(size(rot_u,1),6);
    for rot_no=1:numel(rot_u)
        idx=find(swap_info(:,1)==box_u(box_no) & swap_info(:,4)==rot_u(rot_no));
        scores_idx=[pred_scores(idx) gt_scores(idx,:)];
%       averages(rot_no,:)=median(scores_idx,1);
        averages(rot_no,:)=mean(scores_idx,1);
        [~,idx_max]=max(scores_idx(:,1),[],1);
        swap_avg_best(rot_no,:)=swap_info(idx(idx_max),:);
        score_avg_best(rot_no,:)=scores_idx(idx_max,:);
    end
    [~,idx_best_rot]=max(averages(:,1),[],1);
    bestSwapsAvg(box_no,:)=swap_avg_best(idx_best_rot,:);
    bestScoresAvg(box_no,:)=score_avg_best(idx_best_rot,:);
end

[box_nos,bool_keep,score_infos,swap_infos]=getBestSwapPerBoxInfo(data,pred_score_org);

bestScoresAvg-score_infos

% [box_nos,keep_bool,score_infos,swap_infos]=getBestSwapPerBoxInfo(data,pred_score_org);
