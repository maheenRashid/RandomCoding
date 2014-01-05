ccc

load(fullfile('..','record_dpm'));
load(fullfile('..','dpm_greater_-1_bbox_record_withDetections'),...
    'record_labelMe');

ids_labelMe=record_labelMe(1,:);
tmp=cell(size(record_dpm)); 
[record_dpm(:).total_gt]=deal(tmp{:})

for mod_no=1:numel(record_dpm)
    id=record_dpm(mod_no).id;
    idx_labelMe=~cellfun(@isempty,strfind(ids_labelMe,id));
    labelMe_curr=record_labelMe(:,idx_labelMe);
    total_gt=size(labelMe_curr{2},2);
    record_dpm(mod_no).total_gt=total_gt;
    
end

save(fullfile('..','record_dpm'),'record_dpm');


% sanity_check_ans=sum(sanity_check(1,:))/sum(sanity_check(2,:))
% 
% %get recall
% for mod_no=1:numel(record_dpm)
%     uni=unique(record_dpm(mod_no).obj_map);
%     uni(uni==0)=[];
%     recall(1,mod_no)=numel(uni);
%     recall(2,mod_no)=record_dpm(mod_no).total_gt;
% end
% 
% recall_ans=sum(recall(1,:))/sum(recall(2,:))
