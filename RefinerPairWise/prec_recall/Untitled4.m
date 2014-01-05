ccc
load('b#bedroom#sun_aaaxduqfqjdvroqe.mat');
%create vector_features

%step one. remove the feature vecs
% thresh=threshes(thresh_no);
 thresh=0.1751;
[features_prune,lists_bin]=...
    thresholdFeatures(record_lists.feature_vecs,thresh);

%step two. get dpm bin for thresh
dpm_bin=record_lists.dpm_scores>=(thresh-1);

%sanity check. all of the excluded dpms' columsn should be zero
features_t=cell2mat(features_prune');
features_t=features_t(2:end,:);
check=sum(features_t,2);
check=check>0;
if ~isequal(dpm_bin,check)
    keyboard;
end

%include geo score and exclude the bad dpm cols
dpm_bin=[true;dpm_bin];

features_prune=cellfun(@(x) x(dpm_bin),features_prune,'UniformOutput',0);

%do some renaming and adding
record_lists.feature_vecs_all=record_lists.feature_vecs;
record_lists.features_vecs=features_prune;
record_lists.dpm_thresh_bin=dpm_bin;
record_lists.lists_thresh_bin=lists_bin;
