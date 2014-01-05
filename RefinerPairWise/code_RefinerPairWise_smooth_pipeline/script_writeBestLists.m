in_dir=['swapAllCombos_unique_' num2str(n) '_' folder_type{folder_no} ...
    '_writeAndScoreLists_html'];

dir_lists=fullfile(dir_parent,in_dir,'record_lists');

dirs_all=cellfun(@(x) fullfile(dir_parent,in_dir,['results_' x '_ratioEqual']),...
    dirs_str,'UniformOutput',0);

out_dirs=cellfun(@(x) fullfile(dir_parent,in_dir,['best_list_' x]),...
    dirs_str,'UniformOutput',0);

for exp_no=1:numel(dirs_all)
    in_dir_curr=dirs_all{exp_no};
    out_dir_curr=out_dirs{exp_no};
    if ~exist(out_dir_curr,'dir')
        mkdir(out_dir_curr);
    end
    
    models=dir(fullfile(in_dir_curr,'*.mat'));
    %check for whether the previous stage has completed
    bytes_all=[models(:).bytes];
    models(bytes_all<200)=[];
    
    %get names
    models={models(:).name};
    models=cellfun(@(x) x(1:end-4),models,'UniformOutput',0);
    matlabpool open;
    parfor model_no=1:numel(models)
        temp=load(fullfile(in_dir_curr,[models{model_no} '.mat']))
        b_gt=temp.record_lists.best_list_idx_gt;
        b_pred=temp.record_lists.best_list_idx_pred;
        temp=load(fullfile(dir_lists,[models{model_no} '.mat']));
        lists=temp.record_lists.lists;
        out_file_name=fullfile(out_dir_curr,[models{model_no} '.txt']);
        writeLists(out_file_name,lists,b_gt,b_pred);
    end
    matlabpool close
end

