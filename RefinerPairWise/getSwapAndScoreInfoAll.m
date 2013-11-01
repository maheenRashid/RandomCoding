function [box_ids,swap_info,pred_scores,gt_scores]=getSwapAndScoreInfoAll(data)

idx_keep=regexpi(data,'After repInd box\w*');
idx_keep=find(~(cellfun(@isempty,idx_keep)));
idx_keep_1=regexpi(data(idx_keep),'\w*: score\w*');
idx_keep_1=find(~(cellfun(@isempty,idx_keep_1)));
idx_keep=idx_keep(idx_keep_1);

box_ids=zeros(numel(idx_keep),1);
pred_scores=zeros(numel(idx_keep),1);
gt_scores=zeros(numel(idx_keep),5);
swap_info=zeros(numel(idx_keep),5);
for i=1:numel(idx_keep)
    str_curr=data{idx_keep(i)};
    str_curr=regexpi(str_curr,' ','split');
    box_ids(i)=str2double(str_curr{4});
    pred_scores(i)=str2double(str_curr{end});
    gt_scores(i,:)=getGTScoresFromStr(data{idx_keep(i)+1});
    str_curr=data{idx_keep(i)+1};
    str_curr=regexpi(str_curr,' ','split');
    str_curr=str_curr(4:2:12);
    str_curr{end}=str_curr{end}(1:end-1);
    swap_info(i,:)=cellfun(@str2double,str_curr);

end


end