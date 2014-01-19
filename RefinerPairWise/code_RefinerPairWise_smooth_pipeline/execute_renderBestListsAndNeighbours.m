ccc

load('path_to_cellCommands_best_list.mat','path_to_cellCommands');
load('path_to_cellCommands_best_list_neighbours.mat',...
    'path_to_cellCommands_neighbours');
executeMatFiles( path_to_cellCommands );
executeMatFiles( path_to_cellCommands_neighbours );
