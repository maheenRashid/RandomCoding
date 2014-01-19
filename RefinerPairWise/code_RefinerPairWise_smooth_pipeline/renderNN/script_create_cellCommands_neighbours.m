ccc
dir_parent='/lustre/maheenr/results_temp_09_13';
file='swapObjectsInBox_allOffsets_sizeComparison_bugFixed_gt';
folder='swapObjectsInBox_allOffsets_sizeComparison_bugFixed_gt_refPW';
c_out_folder='swapAllCombos_unique_3_gt';
c_file_to_run='renderLists';
nn_folder_meta='swapAllCombos_unique_3_gt_writeAndScoreLists_html';
path_to_text=fullfile(dir_parent,folder,'text_files');


k_vec= 0.01:0.01:0.1;

out_dir='knn_renderLists_neighbours';
if ~exist(out_dir)
    mkdir(out_dir);
end

mat_files=cell(1,0);
for k_no=k_vec
    
    dir_nn_mat=fullfile(dir_parent,nn_folder_meta,['best_list_' ...
        num2str(k_no) '_nn_LOO_neighbours']);
    
    load([file '.mat']);
    load(fullfile(dir_nn_mat,'record_path_nn_text.mat'));
    
    out_name=[c_out_folder '_nn_neighbours_' num2str(k_no)];
    
    cell_struct=struct('cellCommands',cell(numel(record_path_nn_text),1));
    for mod_no=1:numel(record_path_nn_text)
        mod_name=record_path_nn_text(mod_no).mod_name;
        paths_nn=record_path_nn_text(mod_no).paths_nn;
        [cellCommands_rel,out_dirs_curr]=getRelCellCommands(cellCommands,out_name,mod_name,paths_nn);
        cell_struct(mod_no).cellCommands=createRenderListsMat(cellCommands_rel,c_file_to_run,...
            path_to_text,paths_nn,out_dirs_curr,file);
    end
    cellCommands=[cell_struct(:).cellCommands];
    cellCommands=cellCommands(:);
    save(fullfile(out_dir,[out_name '.mat']),'cellCommands');
    mat_files=[mat_files fullfile(out_dir,out_name)];
end
save('folders_for_execute_script_neighbours.mat','mat_files');






