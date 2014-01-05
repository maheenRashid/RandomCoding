ccc

dir_parent='/home/maheenr/results_temp_09_13';
folder='swapAllCombos_unique_10_gt_writeAndScoreLists';

%get model names
dir_lists=fullfile(dir_parent,[folder '_html'],'record_lists_dpm_bin');
dir_nn_results=fullfile(dir_parent,[folder '_html'],'results_testTrainData_LOO_ratioEqual');

models=dir(fullfile(dir_nn_results,'*.mat'));

%check for whether the previous stage has completed
bytes_all=[models(:).bytes];
models(bytes_all<200)=[];

%get names
models={models(:).name};
models=cellfun(@(x) x(1:end-4),models,'UniformOutput',0);

%create directory for output
out_dir=fullfile(dir_parent,[folder '_html'],'results_accuracy_nn_ratioEqual');
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end


for model_no=1:numel(models)
    out_file_name=fullfile(out_dir,[models{model_no} '.mat']);
    if exist(out_file_name,'file')
        continue
    else
        dummy=struct();
        save(out_file_name,'dummy');
    end
    
    load(fullfile(dir_nn_results,[models{model_no} '.mat']),...
        'best_list_idx_gt','best_list_idx_pred');
    load(fullfile(dir_lists,[models{model_no} '.mat']));
    accuracy=record_lists.accuracy;
%     accuracy=accuracy([best_list_idx_gt,best_list_idx_pred]);
    
    record_accuracy=struct();
    record_accuracy.name=models{model_no};
    record_accuracy.gt=accuracy{best_list_idx_gt};
    record_accuracy.pred=accuracy{best_list_idx_pred};
    save(out_file_name,'record_accuracy');
    
end
