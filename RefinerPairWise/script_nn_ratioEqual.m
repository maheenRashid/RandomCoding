ccc

addpath('../svm_files');

dir_parent='/home/maheenr/results_temp_09_13';
folder='swapAllCombos_unique_10_gt_writeAndScoreLists';

%get model names
dir_feature_vec=fullfile(dir_parent,[folder '_html'],'record_lists_feature_vecs');
dir_nn_loo=fullfile(dir_parent,[folder '_html'],'testTrainData_LOO_ratioEqual');

models=dir(fullfile(dir_nn_loo,'*.mat'));

%check for whether the previous stage has completed
bytes_all=[models(:).bytes];
models(bytes_all<200)=[];

%get names
models={models(:).name};
models=cellfun(@(x) x(1:end-4),models,'UniformOutput',0);

%create directory for output
out_dir=fullfile(dir_parent,[folder '_html'],'results_testTrainData_LOO_ratioEqual');
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end

 s = RandStream.create('mt19937ar','seed',sum(100*clock));
 RandStream.setDefaultStream(s);

for model_no=1:numel(models)
    out_file_name=fullfile(out_dir,[models{model_no} '.mat']);
    
%     sec=clock();sec=sec(end);
    pause(rand);
    
    if exist(out_file_name,'file')
        continue;
    else
        dummy=struct();
        parsave(out_file_name,dummy);
    end
    
    load(fullfile(dir_nn_loo,models{model_no}));
    train_data=record_lists.train_data;
    test_data=record_lists.test_data;
    
    train_data.X=normr(train_data.X);
    test_data.X=normr(test_data.X);
    
%     tic()
    NS = KDTreeSearcher(train_data.X);
%     toc()
    
    %for testing
%     test_data.X=test_data.X(1:50,:);
%     test_data.y=test_data.y(1:50);
    
    svm_vecs_curr=test_data.X;
    det_scores_curr=test_data.y;
    det_scores_pred=zeros(size(det_scores_curr));
    det_scores_idx=det_scores_pred;
    
    for check=1:size(svm_vecs_curr,1)      
        IDX = knnsearch(sparse(train_data.X),sparse(svm_vecs_curr(check,:)));
        det_scores_pred(check)=train_data.y(IDX);
        det_scores_idx(check)=IDX;
    end
    
    best_list_idx_pred=getBestListIdx_geoScore(det_scores_pred,svm_vecs_curr);
    best_list_idx_gt=getBestListIdx_geoScore(det_scores_curr,svm_vecs_curr);
    
    
    record_lists.det_scores_pred=det_scores_pred;
    record_lists.det_scores_idx=det_scores_idx;
    record_lists.best_list_idx_pred=best_list_idx_pred;
    record_lists.best_list_idx_gt=best_list_idx_gt;
    save(out_file_name,'record_lists','best_list_idx_gt','best_list_idx_pred');
%     parsave(out_file_name,record_lists);
    
end
