function [record_path_nn_text]=writeBestListText(dir_lists,dir_results,out_dir,neighbours_flag,v_no,k)

if nargin<4
    neighbours_flag=0;
end

if ~exist(out_dir,'dir')
    mkdir(out_dir);
end

if ~neighbours_flag
    record_path_nn_text=writeBestList(dir_lists,dir_results,out_dir);
else
    record_path_nn_text=writeBestList_Neighbours(dir_lists,dir_results,out_dir,v_no,k);
end

end

function [record_path_nn_text]=writeBestList(dir_lists,dir_results,out_dir)
mod_files=dir(fullfile(dir_results,'*.mat'));
mod_files={mod_files(:).name};


record_path_nn_text=struct('mod_name',...
    cell(1,numel(mod_files)),'paths_nn',cell(1,numel(mod_files)));
matlabpool open;
parfor mod_no=1:numel(mod_files)
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
matlabpool close;



end


function [record_path_nn_text]=writeBestList_Neighbours(dir_lists,dir_results,out_dir_meta,v_no,k)

mod_files=dir(fullfile(dir_results,'*.mat'));
mod_files={mod_files(:).name};

record_path_nn_text=struct('mod_name',cell(1,numel(mod_files)),'paths_nn',cell(1,numel(mod_files)));
matlabpool open
parfor mod_no=1:numel(mod_files)
    
    model_name=regexpi(mod_files{mod_no},'[.]','split');
    model_name=model_name{1};
    out_dir_curr=fullfile(out_dir_meta,model_name);
    if ~exist(out_dir_curr,'dir')
        mkdir(out_dir_curr);
    end
    
    nn=load(fullfile(dir_results,mod_files{mod_no}));
    nn=nn.record_lists;
    [train_mo_no,list_no]=getListNoOfNN(nn,v_no,k);
    
    nn_names=nn.models_curr(train_mo_no);
    
    paths=cell(1,numel(nn_names));
    for nn_no=1:numel(nn_names)
        nn_lists=load(fullfile(dir_lists,nn_names{nn_no}));
        nn_lists=nn_lists.record_lists.lists;
        out_file_name=fullfile(out_dir_curr,[nn_names{nn_no} '_' num2str(nn_no) '.txt']);
        writeLists(out_file_name,nn_lists,list_no(nn_no),list_no(nn_no));
        paths{nn_no}=out_file_name;
    end
    record_path_nn_text(mod_no).mod_name=model_name;
    record_path_nn_text(mod_no).paths_nn=paths;
end
matlabpool close;


end
