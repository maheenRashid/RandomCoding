function [swap_info,scores]=getKeepBoxIdsAndScores(data)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here




idx_keep=regexpi(data,'After Keep\w*');
idx_keep=find(~(cellfun(@isempty,idx_keep)));
idx_keep_1=regexpi(data(idx_keep),'\w*001:\w*');
idx_keep_1=find(~(cellfun(@isempty,idx_keep_1)));
idx_keep=idx_keep(idx_keep_1);


swap_info=zeros(numel(idx_keep),5);
pred_scores=zeros(numel(idx_keep),1);
gt_scores=zeros(numel(idx_keep),5);

for i=1:numel(pred_scores)
    temp=data{idx_keep(i)};
    temp=regexpi(temp,' ','split');
    str_curr=temp(4:2:12);
    swap_info(i,:)=cellfun(@str2double,str_curr);
    gt_scores(i,:)=getGTScoresFromStr(data{idx_keep(i)});
    temp=data{idx_keep(i)-1};
    temp=regexpi(temp,' ','split');
    pred_scores(i)=str2double(temp{end});
end

scores=[pred_scores,gt_scores];



end

