ccc
addpath('../svm_files');

dir_parent='/home/maheenr/results_temp_09_13';
folder='swapAllCombos_unique_10_gt_writeAndScoreLists';

%get model names
dir_feature_vec=fullfile(dir_parent,[folder '_html'],'record_lists_feature_vecs');
models=dir(fullfile(dir_feature_vec,'*.mat'));
models={models(:).name};
models=cellfun(@(x) x(1:end-4),models,'UniformOutput',0);

%create directory for output
out_dir=fullfile(dir_parent,[folder '_html'],'testTrainData_LOO_ratioEqual');
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end


%load folds
load ('gt_list_and_fold.mat','gt_list','gt_folds');

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

 s = RandStream.create('mt19937ar','seed',sum(100*clock));
 RandStream.setDefaultStream(s);

%iterate over each set
% matlabpool open
% par
for fold_no=1:numel(names_foldwise)
    fold_no
    models_curr=names_foldwise{fold_no};
    pause(5*rand);
    %temp for testing
%     models_curr=models_curr(1:5);
    
    for test_idx=1:numel(models_curr)
        train_idx=1:numel(models_curr);
        train_idx(test_idx)=[];
        
        out_file_name=fullfile(out_dir,[models_curr{test_idx} '.mat']);
        if exist(out_file_name,'file')
            continue;
        else
            dummy=struct();
            parsave(out_file_name,dummy);
        end
        
        %set ratio
        ratio=[0.5,0.5];

        %get training and testing data in correct format
        disp('getting features and reponse')
        [feature_vecs_all,det_scores_all]=getFeaturesAndReponse(dir_feature_vec,models_curr,ratio);
        disp('getting train test data')
        [train_data,test_data]=getTrainTestData(feature_vecs_all,det_scores_all,test_idx,train_idx);
        
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
    
end
% matlabpool close
