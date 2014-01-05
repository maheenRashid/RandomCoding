
%get model names
models=dir(fullfile(dir_nn_loo,'*.mat'));

%check for whether the previous stage has completed
bytes_all=[models(:).bytes];
models(bytes_all<200)=[];

%get names
models={models(:).name};
models=cellfun(@(x) x(1:end-4),models,'UniformOutput',0);


%create directory for output
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end


matlabpool open;
parfor model_no=1:numel(models)
    model_no
    out_file_name=fullfile(out_dir,[models{model_no} '.mat']);
    
    temp=load(fullfile(dir_nn_loo,models{model_no}));
    record_lists=temp.record_lists;
    
    train_data=record_lists.train_data;
    test_data=record_lists.test_data;
    
    
    X_train_c=[train_data.X, ...
        ones(size(train_data.X,1),1)];
    X_test_c=[test_data.X,ones(size(test_data.X,1),1)];
    
    warning off;
    [b] = regress(record_lists.train_data.y,X_train_c);
    y_pred= X_test_c*b;
    
    if isempty(y_pred)
        record_lists.best_list_idx_pred=zeros(0,1);
        record_lists.best_list_idx_gt=zeros(0,1);
        
        record_lists.det_scores_pred=y_pred;
        parsave(out_file_name,record_lists);
        
    else
        %find the group with the highest score
        test_data_bin=record_lists.test_data.X>0;
        test_data_bin=test_data_bin(:,2:end);
        [C,ia,ic] = unique(test_data_bin,'rows');
        
        sum_scores=arrayfun(@(x) sum(y_pred(ic==x)),1:size(C,1));
        [~,max_idx]=max(sum_scores);
        max_group=find(ic==max_idx);
        
        
        best_list_idx_pred=getBestListIdx_geoScore(y_pred(max_group),...
            record_lists.test_data.X(max_group,:));
        best_list_idx_pred=max_group(best_list_idx_pred);
        
        best_list_idx_gt=getBestListIdx_geoScore(record_lists.test_data.y,...
            record_lists.test_data.X);
        record_lists.best_list_idx_pred=best_list_idx_pred;
        record_lists.best_list_idx_gt=best_list_idx_gt;
        
        record_lists.det_scores_pred=y_pred;
        parsave(out_file_name,record_lists);
    end
    
end
matlabpool close;