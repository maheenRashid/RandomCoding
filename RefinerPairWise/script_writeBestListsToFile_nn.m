ccc

dir_parent='/home/maheenr/results_temp_09_13';
folder='swapAllCombos_unique_10_gt_writeAndScoreLists';

%get model names
dir_lists=fullfile(dir_parent,[folder '_html'],'record_lists');
dir_nn_results=fullfile(dir_parent,[folder '_html'],'results_testTrainData_LOO_ratioEqual');

models=dir(fullfile(dir_nn_results,'*.mat'));

%check for whether the previous stage has completed
bytes_all=[models(:).bytes];
models(bytes_all<200)=[];

%get names
models={models(:).name};
models=cellfun(@(x) x(1:end-4),models,'UniformOutput',0);

%create directory for output
out_dir=fullfile(dir_parent,[folder '_html'],'best_lists_txt');
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end


for model_no=1:numel(models)
    out_file_name=fullfile(out_dir,[models{model_no} '.txt']);
    if exist(out_file_name,'file')
        continue
    else
        fid_w=fopen(out_file_name,'w');
    end
    
    load(fullfile(dir_nn_results,[models{model_no} '.mat']),...
        'best_list_idx_gt','best_list_idx_pred');
    lists=load(fullfile(dir_lists,[models{model_no} '.mat']));
    lists=lists.record_lists.lists;
    lists=lists([best_list_idx_gt,best_list_idx_pred]);
    
    fprintf(fid_w,'%d\n',numel(lists));
    fprintf(fid_w,'%s\n','C');
    for i=1:numel(lists)
        fprintf(fid_w,'%d\n',numel(lists{i}));
        for j=1:numel(lists{i})
            fprintf(fid_w,'%d\n',lists{i}(j));
        end
        fprintf(fid_w,'%s\n','C');
    end
    fclose(fid_w);
    
end

save('models_with_txt.mat','models');