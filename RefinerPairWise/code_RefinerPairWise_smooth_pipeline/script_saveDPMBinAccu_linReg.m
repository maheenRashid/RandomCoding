

in_dir=['swapAllCombos_unique_' num2str(n) '_' folder_type{folder_no} ...
    '_writeAndScoreLists_html'];

dir_lists=fullfile(dir_parent,in_dir,'record_lists_dpm_bin');

out_dir=fullfile(dir_parent,in_dir,'dpm_accu_per_k_per_mod');
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end

dir_nn_results=fullfile(dir_parent,in_dir,['results_linReg_LOO_ratioEqual']);
out_dir_curr=fullfile(out_dir,'linReg');
if ~exist(out_dir_curr,'dir')
    mkdir(out_dir_curr)
end


models=dir(fullfile(dir_nn_results,'*.mat'));

%check for whether the previous stage has completed
bytes_all=[models(:).bytes];
models(bytes_all<200)=[];

%get names
models={models(:).name};
models=cellfun(@(x) x(1:end-4),models,'UniformOutput',0);


for model_no=1:numel(models)
    out_file_name=fullfile(out_dir_curr,[models{model_no} '.mat']);
    %         if exist(out_file_name,'file')
    %             continue
    %         else
    %             dummy=struct();
    %             save(out_file_name,'dummy');
    %         end
    
    load(fullfile(dir_nn_results,[models{model_no} '.mat']))
    best_list_idx_gt=record_lists.best_list_idx_gt;
    best_list_idx_pred=record_lists.best_list_idx_pred;
    
    load(fullfile(dir_lists,[models{model_no} '.mat']));
    accuracy=record_lists.accuracy;
    %     accuracy=accuracy([best_list_idx_gt,best_list_idx_pred]);
    
    record_accuracy=struct();
    record_accuracy.name=models{model_no};
    record_accuracy.gt=accuracy{best_list_idx_gt};
    record_accuracy.pred=accuracy{best_list_idx_pred};
    save(out_file_name,'record_accuracy');
    
end