
function [box_nos,bool_keep,score_infos,swap_infos]=getBestSwapPerBoxInfo(data,pred_score_org)

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

box_nos=unique(box_ids);
swap_infos=zeros(numel(box_nos),5);
score_infos=zeros(numel(box_nos),6);

bool_keep=zeros(numel(box_nos),1);
bool_keep=bool_keep>0;
for i=1:numel(box_nos)
    idx_box_curr=find(box_ids==box_nos(i));
    pred_scores_curr=pred_scores(box_ids==box_nos(i));
    [max_score_curr,idx_max_score]=max(pred_scores_curr);
    bool_keep(i)=max_score_curr>pred_score_org;
    
    idx_max_score=idx_box_curr(idx_max_score);
    
    swap_infos(i,:)=swap_info(idx_max_score,:);
    score_infos(i,1)=max_score_curr;
    score_infos(i,2:end)=gt_scores(idx_max_score,:);
%     keyboard;
end

end