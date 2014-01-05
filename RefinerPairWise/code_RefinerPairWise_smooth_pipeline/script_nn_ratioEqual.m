
in_dir=['swapAllCombos_unique_' num2str(n) '_' folder_type{folder_no} ...
    '_writeAndScoreLists_html'];

addpath(fullfile('..','..','svm_files'));

%get model names
dir_feature_vec=fullfile(dir_parent,in_dir,'record_lists_feature_vecs');
dir_nn_loo=fullfile(dir_parent,in_dir,'testTrainData_LOO_ratioEqual');
models=dir(fullfile(dir_nn_loo,'*.mat'));

%check for whether the previous stage has completed
bytes_all=[models(:).bytes];
models(bytes_all<200)=[];

%get names
models={models(:).name};
models=cellfun(@(x) x(1:end-4),models,'UniformOutput',0);


%create directory for output
out_dir=fullfile(dir_parent,in_dir,['results_' num2str(k) '_nn_LOO_ratioEqual']);
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end


matlabpool open;
parfor model_no=1:numel(models)
    model_no
    out_file_name=fullfile(out_dir,[models{model_no} '.mat']);
    
    %     if exist(out_file_name,'file')
    %         continue;
    %     else
    %         dummy=struct();
    %         parsave(out_file_name,dummy);
    %     end
    
    temp=load(fullfile(dir_nn_loo,models{model_no}));
    record_lists=temp.record_lists;
    train_data=record_lists.train_data;
    test_data=record_lists.test_data;
    
    
    train_data.X=normr(train_data.X);
    test_data.X=normr(test_data.X);
    
    
    svm_vecs_curr=test_data.X;
    det_scores_curr=test_data.y;
    
    %whiten data
    [train_x_n_wh, train_x_n_mu, invMat, whMat] = whiten(train_data.X);
    test_x_n_mu = mean(test_data.X);
    test_x_n_wh=bsxfun(@minus,test_data.X,test_x_n_mu);
    test_x_n_wh = test_x_n_wh*whMat;
    
    
    if isnan(k)
        k_eff=size(train_data.X,1);
    end
    det_scores_pred=zeros(numel(det_scores_curr),k_eff);
    det_scores_idx=zeros(numel(det_scores_curr),k_eff);
    det_scores_d=zeros(numel(det_scores_curr),k_eff);
    for check=1:size(svm_vecs_curr,1)
        [IDX,D] = knnsearch(sparse(train_x_n_wh),...
            sparse(test_x_n_wh(check,:)),'K',k_eff);
        det_scores_pred(check,:)=train_data.y(IDX);
        det_scores_idx(check,:)=IDX;
        det_scores_d(check,:)=D;
    end
    
    %     best_list_idx_pred=getBestListIdx_geoScore(det_scores_pred,svm_vecs_curr);
    %     best_list_idx_gt=getBestListIdx_geoScore(det_scores_curr,svm_vecs_curr);
    
    
    record_lists.det_scores_pred=det_scores_pred;
    record_lists.det_scores_idx=det_scores_idx;
    record_lists.det_scores_d=det_scores_d;
    %     record_lists.best_list_idx_pred=best_list_idx_pred;
    %     record_lists.best_list_idx_gt=best_list_idx_gt;
    parsave(out_file_name,record_lists);
    
    
end
matlabpool close;