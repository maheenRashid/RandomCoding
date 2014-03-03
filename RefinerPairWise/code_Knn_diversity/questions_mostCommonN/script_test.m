 ccc
 
 load('gt_list_and_fold.mat');
 
 folds=unique(gt_folds);
 folds=num2cell(folds);
 m_common=struct('fold_no',folds,...
     'incidenceNumber',cell(size(folds)),'diversityNumber',cell(size(folds)));
 
 in_dir=
 out_dir='questions_mostCommonN';
 
 if ~exist(out_dir,'dir')
     mkdir(out_dir);
 end
 
 fold_no=1
     %:numel(folds)
 models_list=gt_list(gt_folds==folds(fold_no));
 models=cellfun(@(x) [x '.mat'],models,'UniformOutput',0);
 
 models_we_have=dir(fullfile(in_dir,'*.mat'));
 models_we_have={models_we_have(:).name};
 models=intersect(models_we_have,models);
 div_no_mat=zeros(0,numel(models));
 inc_no_mat=zeros(0,1);
 for model_no=1:numel(models)
    x=load(fullfile(in_dir,models{model_no}));
    feat_mat=cell2mat(x.record_lists.feature_vecs_all);
    feat_count=size(feat_mat,1);
    if model_no==1
        div_no_mat=[div_no_mat;zeros(feat_count,size(div_no_mat,2))];
        inc_no_mat=[inc_no_mat;zeros(inc_no_mat,size(inc_no_mat,2))];
    end
    
    
    
    
 end
 
 
 
 
 