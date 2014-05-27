ccc

cam_dir_meta='/lustre/maheenr/cube_per_cam_regenerate';
gt_dir='room3D_gt';

% dir_proc_old='processing_lists';
% dir_proc='processing_lists_no_neg';

dir_proc_old='processing_lists_no_neg_noprune';
dir_proc='processing_lists_no_neg_prune';
in_dir=fullfile(cam_dir_meta,gt_dir,dir_proc_old,'record_lists');
out_dir=fullfile(cam_dir_meta,gt_dir,dir_proc,'record_lists');
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end

names=dir(fullfile(in_dir,'*.mat'));
names={names(:).name};


str='b#bedroom#sun_aaiuzbtklnxpvzbv';
load('../gt_list_and_fold.mat');
idx=find(strcmp(str,gt_list));
fold=gt_folds(idx);
gt_rel=gt_list(gt_folds==fold);
names_cut=cellfun(@(x) x(1:end-4),names,'UniformOutput',0);
[names_rel,idx_gt,idx_dir]=intersect(gt_rel,names_cut);
names=names(idx_dir);
gt_rel=gt_rel(idx_gt);


for model_no=1:numel(names)
    fprintf('model no %d\n',model_no);
record_lists=load(fullfile(in_dir,names{model_no}));
record_lists=record_lists.record_lists;

[bin_neg]=getBinNeg(record_lists.box_nos,record_lists.box_dim);
black_list=find(bin_neg);
black_list=black_list-1;
list_bin=cellfun(@(x) sum(ismember(x,black_list)),record_lists.lists);
list_bin=list_bin>0;

record_lists.lists(list_bin)=[];
record_lists.scores(list_bin)=[];
record_lists.gt_scores(list_bin,:)=[];

save(fullfile(out_dir,names{model_no}),'record_lists');

end




return
ccc

%find the negs
%
% rec_dir=...;
% names=dir(fullfile(rec_dir,'*.mat'));
% names={names(:).name};
%
% for model_no=1:numel(names)
%     rec=load(fullfile(rec_dir,names{model_no}));

load ('list_swap_debug.mat','list');
rec=list;

box_nos=rec.record_lists.box_nos;
box_nos=box_nos+1;
boxes=rec.record_lists.box_dim;
boxes=boxes(box_nos,:);

bin_neg=zeros(size(boxes,1),1);
for box_no=1:size(boxes,1)
    %         keyboard;
    box_curr=boxes(box_no,:);
    box_curr=reshape(box_curr,3,2);
    box_curr=box_curr';
    bin=box_curr<0;
    bin=sum(bin,1);
    bin_neg(box_no)=sum(bin==2);
end
list=find(bin_neg);
list=list-1;
lists={list,list};
out_file_name='test_neg_list.txt'
writeLists(out_file_name,lists,1,1);