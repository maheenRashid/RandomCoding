features_mat=dir(fullfile(feature_dir,'*.mat'));
features_mat={features_mat(:).name};

dpm_scores_all=cell(numel(features_mat),1);
for mat_no=1:numel(features_mat)
    temp=load(fullfile(feature_dir,features_mat{mat_no}));
    record_lists=temp.record_lists;
    dpm_scores_all{mat_no}=record_lists.dpm_scores;
end

dpm_scores_all=cell2mat(dpm_scores_all);

%get thresholds and prctile str
threshes=prctile(dpm_scores_all,prctile_vec);
%add one for thresholding feature vecs
threshes=threshes+1;