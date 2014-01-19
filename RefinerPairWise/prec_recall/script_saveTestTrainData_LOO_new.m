%difference with _LOO.m is that this includes whitening.
%also path names are in meta script.

addpath(fullfile('..','..','svm_files'));
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


%iterate over each set
for fold_no=1:numel(names_foldwise)
    fold_no
    models_curr=names_foldwise{fold_no};

    matlabpool open
    parfor test_idx=1:numel(models_curr)
        train_idx=1:numel(models_curr);
        train_idx(test_idx)=[];
        
        out_file_name=fullfile(out_dir,[models_curr{test_idx} '.mat']);
        
        %set ratio
        ratio=[0.5,0.5];

        %get training and testing data in correct format
        [feature_vecs_all,det_scores_all]=getFeaturesAndReponse_noOrder...
            (dir_feature_vec,models_curr,ratio);
        
        [train_data,test_data]=getTrainTestData...
            (feature_vecs_all,det_scores_all,test_idx,train_idx);
%         keyboard;
        if isempty(train_data.X)
            continue;
        end
        
        
        [train_data,test_data]=whitenData(train_data,test_data);
        
        %save
        record_data=struct();
        record_data.models_curr=models_curr;
        record_data.test_idx=test_idx;
        record_data.train_idx=train_idx;
        record_data.ratio=ratio;
        record_data.test_data=test_data;
        record_data.train_data=train_data;
        record_data.feature_vecs_all=feature_vecs_all;
        record_data.det_scores_all=det_scores_all;
        parsave(out_file_name,record_data);
        
    end
    
    matlabpool close    
end

rmpath(fullfile('..','..','svm_files'));