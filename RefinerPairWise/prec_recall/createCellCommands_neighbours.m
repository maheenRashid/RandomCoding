function [ cellCommands ] = createCellCommands_neighbours( record_path_nn_text,cellCommands_struct,out_name )
%UNTITLED18 Summary of this function goes here
%   Detailed explanation goes here
    
    cellCommands=cellCommands_struct.cellCommands;
    c_file_to_run=cellCommands_struct.c_file_to_run;
    path_to_text=cellCommands_struct.path_to_text;
    file=cellCommands_struct.file;

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
%     save(fullfile(out_dir,[out_name '.mat']),'cellCommands');
%     mat_files=[mat_files fullfile(out_dir,out_name)];

end

