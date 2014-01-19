

in_dir=['swapAllCombos_unique_' num2str(n) '_' folder_type{folder_no} ...
    '_writeAndScoreLists_html'];
dir_dpm_bin=fullfile(dir_parent,in_dir,'record_lists_dpm_bin');

models=dir(fullfile(dir_dpm_bin,'*.mat'));
models={models(:).name};
models=cellfun(@(x) x(1:end-4),models,'UniformOutput',0);

out_dir=fullfile(dir_parent,in_dir,'record_lists_feature_vecs_withCat');
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end

map=[1,2,4,8,9];

matlabpool open
parfor model_no=1:numel(models)
    model_no
    temp=load(fullfile(dir_dpm_bin,[models{model_no} '.mat']));
    record_lists=temp.record_lists;
    pred_score=cell2mat(record_lists.scores');
    dpm_score=record_lists.dpm_scores;
    dpm_score=dpm_score+1;
    dpm_scores=cellfun(@(x) dpm_score.*x(:,3),record_lists.accuracy,'UniformOutput',0);
    
    cat_feature=getFeature_CatNo(record_lists.cat_nos,map);
    cat_features=cell(numel(dpm_scores),1);
    [cat_features{:}]=deal(cat_feature);
    
    feature_vecs=cellfun(@(x,y) [x;y],record_lists.scores,dpm_scores','UniformOutput',0);
    
    record_lists.feature_vecs=feature_vecs;
    record_lists.cat_feature_vecs=cat_features;
    out_file_name=fullfile(out_dir,[models{model_no} '.mat']);
    parsave(out_file_name,record_lists);
end
matlabpool close

