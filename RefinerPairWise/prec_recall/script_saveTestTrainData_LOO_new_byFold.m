%difference with _LOO.m is that this includes whitening.
%also path names are in meta script.


%create directory for output
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end


models=dir(fullfile(dir_feature_vec,'*.mat'));
models={models(:).name};
models=cellfun(@(x) x(1:end-4),models,'UniformOutput',0);


%load folds
load (fullfile('..','gt_list_and_fold.mat'),'gt_list','gt_folds');

%for ease, remove names not in folder
bin_removal=zeros(1,numel(gt_list));
for i=1:numel(gt_list)
    if sum(strcmp(gt_list{i},models))==0
        bin_removal(i)=1;
    end
end
bin_removal=bin_removal>0;
gt_list(bin_removal)=[];
gt_folds(bin_removal)=[];


%create sets of names based on folds
fold_nos=unique(gt_folds);
names_foldwise=cell(1,numel(fold_nos));
for i=1:numel(fold_nos)
    names_foldwise{i}=gt_list(gt_folds==fold_nos(i));
end


for fold_no=1:numel(names_foldwise)
    models_curr=names_foldwise{fold_no};
    
    out_mutex=fullfile(out_dir,num2str(fold_no));
    
    if ~exist(out_mutex,'dir')
        mkdir(out_mutex);
    else
        continue;
    end
    
    %set ratio
    ratio=[0.5,0.5];
    %get training and testing data in correct format
    tic()
    [feature_vecs_all,det_scores_all,error_files]=getFeaturesAndReponse_noOrder...
        (dir_feature_vec,models_curr,ratio);
    toc()
    save(fullfile(out_mutex,[num2str(fold_no) '.mat']));
    
    
end

