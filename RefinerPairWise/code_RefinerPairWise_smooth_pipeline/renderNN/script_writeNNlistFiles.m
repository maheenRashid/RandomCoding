ccc
dir_parent='/lustre/maheenr/results_temp_09_13';
in_dir='swapAllCombos_unique_3_gt_writeAndScoreLists_html';
dir_lists=fullfile(dir_parent,in_dir,'record_lists');

v_no=5;

for k=0.01:0.01:0.1
    fprintf('k %d\n',k);
    path_nn=fullfile(dir_parent,in_dir,...
        ['results_' num2str(k) '_nn_LOO_ratioEqual']);
    out_dir_meta=fullfile(dir_parent,in_dir,['best_list_' ...
        num2str(k) '_nn_LOO_neighbours']);
    if ~exist(out_dir_meta,'dir')
        mkdir(out_dir_meta);
    end
    
    mod_files=dir(fullfile(path_nn,'*.mat'));
    mod_files={mod_files(:).name};
    
    
    record_path_nn_text=struct('mod_name',cell(1,numel(mod_files)),'paths_nn',cell(1,numel(mod_files)));
    matlabpool open
    parfor mod_no=1:numel(mod_files)
        fprintf('mod no %d of %d\n',mod_no,numel(mod_files));
        model_name=regexpi(mod_files{mod_no},'[.]','split');
        model_name=model_name{1};
        out_dir_curr=fullfile(out_dir_meta,model_name);
        if ~exist(out_dir_curr,'dir')
            mkdir(out_dir_curr);
        end
        
        nn=load(fullfile(path_nn,mod_files{mod_no}));
        nn=nn.record_lists;
        [train_mo_no,list_no]=getListNoOfNN(nn,v_no,k);
        %get model names and lists.
        nn_names=nn.models_curr(train_mo_no);
        %write them to files
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
    save(fullfile(out_dir_meta,'record_path_nn_text.mat'),'record_path_nn_text');
end



%do some ninja cell commanding
%yay