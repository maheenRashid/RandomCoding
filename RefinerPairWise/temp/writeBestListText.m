function [record_path_nn_text]=writeBestListText(dir_lists,dir_results,out_dir)

mod_files=dir(fullfile(dir_results,'*.mat'));
mod_files={mod_files(:).name};


record_path_nn_text=struct('mod_name',...
    cell(1,numel(mod_files)),'paths_nn',cell(1,numel(mod_files)));

for mod_no=1:numel(mod_files)
    model_name=regexpi(mod_files{mod_no},'[.]','split');
    model_name=model_name{1};
    nn_lists=load(fullfile(dir_lists,mod_files{mod_no}));
    nn_lists=nn_lists.record_lists.lists;
    out_file_name=fullfile(out_dir,[model_name '.txt']);
    nn_results=load(fullfile(dir_results,mod_files{mod_no}));
    best_gt=nn_results.record_lists.best_list_idx_gt;
    best_pred=nn_results.record_lists.best_list_idx_pred;
    writeLists(out_file_name,nn_lists,best_gt,best_pred);
    record_path_nn_text(mod_no).mod_name=model_name;
    record_path_nn_text(mod_no).paths_nn=out_file_name;
end





end
