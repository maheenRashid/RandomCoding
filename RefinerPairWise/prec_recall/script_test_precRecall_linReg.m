ccc
load prec_recall_compiled

pr=getPrecRecallCompiled(prec_recall);
% 
% fields=fieldnames(prec_recall);
% fields=fields(2:end);
% pr=zeros(2,numel(fields));
% for field_no=1:numel(fields)
%     pr_curr=cell2mat(eval(['{prec_recall(:).' fields{field_no} '}']));
%     for pr_no=1:2
%         temp=pr_curr(:,pr_no:2:end);
%         temp=sum(temp,2);
%         pr(pr_no,field_no)=temp(1)/temp(2);
%     end
%     fprintf('%s prec: %s, recall: %s\n',fields{field_no},...
%         num2str(pr(1,field_no)),num2str(pr(2,field_no)));
% end


return
ccc

load l#living_room#sun_aykkdobyhjevkiib.mat
tmp=cell(1,100);
prec_recall=struct('dpm',tmp,'nn_dpm',tmp,'nn_dpm_best',tmp);

prec_recall(1)=getPrecRecallStruct(prec_recall(1),record_accuracy);
return
% prec_recall=struct();
% prec_recall.dpm=zeros(2,2);
% prec_recall.nn_dpm=zeros(2,2);
% prec_recall.nn_dpm_best=zeros(2,2);

dpm_bin=record_accuracy.dpm_bin;

[prec_recall.dpm]=getPrecRecall(ones(size(dpm_bin))...
    ,dpm_bin,record_accuracy.obj_map,record_accuracy.total_gt);

if isempty(record_accuracy.pred)
    bin_kept_nn=record_accuracy.pred;
    bin_kept_nn_best=record_accuracy.pred;
else
    bin_kept_nn=record_accuracy.pred(:,end);
    bin_kept_nn_best=record_accuracy.gt(:,end);
end
[prec_recall.nn_dpm]=getPrecRecall(bin_kept_nn,dpm_bin,...
    record_accuracy.obj_map,record_accuracy.total_gt);
[prec_recall.nn_dpm_best]=getPrecRecall(bin_kept_nn_best,dpm_bin,...
    record_accuracy.obj_map,record_accuracy.total_gt);

% nn_dpm_vec=record_accuracy.pred;
% nn_dpm_vec=nn_dpm_vec(nn_dpm_vec(:,end)>0,:);
% 
% nn_dpm_best_vec=record_accuracy.gt;
% nn_dpm_best_vec=nn_dpm_best_vec(nn_dpm_best_vec(:,end)>0,:);




    




return
ccc


load(fullfile('..','record_dpm'));
model_no=1;


mod_name='l#living_room#sun_ajvsjzzxasdcepgx.mat'
load('l#living_room#sun_ajvsjzzxasdcepgx.mat')
record_lists_fl=record_lists;

load('l#living_room#sun_ajvsjzzxasdcepgx_pred.mat')

%get best list idx
best_gt=record_lists.best_list_idx_gt;
best_pred=record_lists.best_list_idx_pred;

%get dpm thresh and accuracy
accu=pruneAccuracyByThresh(record_lists_fl);

%find dpm idx
mod_name_cut=regexpi(mod_name,'#','split');
mod_name_cut=mod_name_cut{end};
mod_name_cut=mod_name_cut(1:end-4);
dpm_ids={record_dpm(:).id};
idx=find(strcmp(mod_name_cut,dpm_ids));

%get cut up obj map
obj_map=record_dpm(idx).obj_map;
obj_map=obj_map(record_lists_fl.dpm_thresh_bin(2:end));
total_gt=record_dpm(idx).total_gt;

    dpm_bin=record_lists_fl.accuracy;
    dpm_bin=temp{1};
    dpm_bin=temp(:,2);
    dpm_bin=temp(record_lists_fl.dpm_thresh_bin(2:end));


% record_accuracy=struct();
% record_accuracy.name=models{model_no};
% record_accuracy.gt=accu{best_gt};
% record_accuracy.pred=accu{best_pred};
% record_accuracy.total_gt=total_gt;
% record_accuracy.obj_map=obj_map;
