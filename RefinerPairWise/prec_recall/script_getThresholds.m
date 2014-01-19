load(fullfile('..','record_dpm'),'record_dpm');

if ~exist(out_dir,'dir')
    mkdir(out_dir);
end


features_mat=dir(fullfile(feature_dir,'*.mat'));
features_mat={features_mat(:).name};

feature_names=cellfun(@(x) x{end-1},...
    cellfun(@(x) regexpi(x,'[#.]','split'),features_mat,'UniformOutput',0)...
    ,'UniformOutput',0);

dpm_names={record_dpm(:).id};
[common,idx_feature,idx_dpm]=intersect(feature_names,dpm_names);
record_dpm_p=record_dpm(idx_dpm);


%get dpm scores
dpm_scores={record_dpm_p(:).boxes};
dpm_scores=cellfun(@(x) x(:,end),dpm_scores,'UniformOutput',0);
dpm_bin={record_dpm_p(:).obj_map};
total_gt={record_dpm_p(:).total_gt};

%go over all the unique scores as thresholds
threshes=cell2mat(dpm_scores');
threshes=sort(unique(threshes));
threshes_bef=threshes;
[prec_per_thresh,recall_per_thresh,number_per_thresh]=...
    getPrecRecallPerThreshDpm(threshes,dpm_scores,dpm_bin,total_gt);

%get the threshes for certain prec thresholds
prct_vec=min(prec_per_thresh):0.05:max(prec_per_thresh);
prct_vec(end)=max(prec_per_thresh);

threshes_new=zeros(size(prct_vec));
for prct_no=1:numel(prct_vec)
    prct_curr=prct_vec(prct_no);
    threshes_new(prct_no)=min(threshes(prec_per_thresh>=prct_curr));
end
threshes=threshes_new;

[prec_per_thresh_aft,recall_per_thresh_aft,number_per_thresh_aft]=...
    getPrecRecallPerThreshDpm(threshes,dpm_scores,dpm_bin,total_gt);


record_threshes=struct();

record_threshes.threshes_bef=threshes_bef;
record_threshes.prec_per_thresh_bef=prec_per_thresh;
record_threshes.recall_per_thresh_bef=recall_per_thresh;
record_threshes.number_per_thresh_bef=number_per_thresh;

record_threshes.threshes_aft=threshes;
record_threshes.prec_per_thresh_aft=prec_per_thresh_aft;
record_threshes.recall_per_thresh_aft=recall_per_thresh_aft;
record_threshes.number_per_thresh_aft=number_per_thresh_aft;

record_threshes.dpm_scores=dpm_scores;
record_threshes.dpm_bin=dpm_bin;
record_threshes.total_gt=total_gt;
record_threshes.prct_vec=prct_vec;

%save the all the info
save(fullfile(out_dir,'record_threshes.mat'),'record_threshes');