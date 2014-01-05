
% in_dir=['swapAllCombos_unique_' num2str(n) '_' folder_type{folder_no} ...
%     '_writeAndScoreLists_html'];
% 
% dir_k=fullfile(dir_parent,in_dir,['results_' num2str(k) '_nn_LOO_ratioEqual']);
% 
% models=dir(fullfile(dir_k,'*.mat'));
% 
% %check for whether the previous stage has completed
% bytes_all=[models(:).bytes];
% models(bytes_all<200)=[];
% 
% %get names
% models={models(:).name};
% models=cellfun(@(x) x(1:end-4),models,'UniformOutput',0);
% 
% matlabpool open
% parfor model_no=1:numel(models)
%     model_no
%     temp=load(fullfile(dir_k,[models{model_no} '.mat']));
    temp=load('b#bedroom#sun_acqsqjhtcbxeomux.mat');
    record_lists=temp.record_lists;
    
    %get best gt
    det_scores_curr=record_lists.test_data.y;
    svm_vecs_curr=record_lists.test_data.X;
    best_list_idx_gt=getBestListIdx_geoScore(det_scores_curr,svm_vecs_curr);
    
    det_scores_pred=record_lists.det_scores_pred;
    det_scores_d=record_lists.det_scores_d;
    %get best pred for different k percent
    
%     for 
        k_p=0.01
%         k_p_vec
%         out_dir=fullfile(dir_parent,in_dir,['results_' num2str(k_p) ...
%             '_nn_LOO_ratioEqual']);
%         if ~exist(out_dir,'dir')
%             mkdir(out_dir)
%         end
%         
        [avg_pred_score]=getWeightedAvgTopK(det_scores_pred,det_scores_d,k_p);
        best_list_idx_pred=getBestListIdx_geoScore(avg_pred_score,svm_vecs_curr);
        record_lists.best_list_idx_pred=best_list_idx_pred;
        record_lists.best_list_idx_gt=best_list_idx_gt;
%         out_file_name=fullfile(out_dir,[models{model_no} '.mat']);
%         parsave(out_file_name,record_lists);
%     end
    
    
% end
% matlabpool close;