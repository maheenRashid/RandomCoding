
features_mat=dir(fullfile(feature_dir,'*.mat'));
features_mat={features_mat(:).name};

for thresh_no=1:numel(threshes)
    
    thresh=threshes(thresh_no);
    thresh=thresh+1;
    out_dir=[feature_dir '_' prctile_str{thresh_no}];
    if ~exist(out_dir,'dir')
        mkdir(out_dir)
    end
    
    matlabpool open
    parfor mat_no=1:numel(features_mat)
        record_lists=load(fullfile(feature_dir,features_mat{mat_no}));
        record_lists=record_lists.record_lists;
        %create vector_features
        
        %step one. remove the feature vecs
        [features_prune,lists_bin]=...
            thresholdFeatures(record_lists.feature_vecs,thresh);
        
        %step two. get dpm bin for thresh
        dpm_bin=record_lists.dpm_scores>=(thresh-1);
        
        %include geo score and exclude the bad dpm cols
        dpm_bin=[true;dpm_bin];
        
%         sanity check. all of the excluded dpms' columsn should be zero
%         features_t=cell2mat(features_prune');
%         check=sum(features_t,2);
%         if sum(check(~dpm_bin))~=0
%             keyboard;
%         end
        
        
        
        features_prune=cellfun(@(x) x(dpm_bin),features_prune,'UniformOutput',0);
        
        %do some renaming and adding
        record_lists.feature_vecs_all=record_lists.feature_vecs;
        record_lists.feature_vecs=features_prune;
        record_lists.dpm_thresh_bin=dpm_bin;
        record_lists.lists_thresh_bin=lists_bin;
        
        %save
        out_file_name=fullfile(out_dir,features_mat{mat_no});
        parsave(out_file_name,record_lists);
        
    end
    matlabpool close;
end