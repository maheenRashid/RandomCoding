ccc
% cell_temp=cell(1,2);
% 
% 
% load('path_to_cellCommands_best_list_diversity.mat','path_to_cellCommands');
% cell_temp{2}=path_to_cellCommands;
% load('path_to_cellCommands_best_list_neighbours_diversity.mat','path_to_cellCommands_neighbours');
% cell_temp{2}=path_to_cellCommands_neighbours;
% 
% 
% for j=1:numel(cell_temp)
%     path_to_cellCommands=cell_temp{j};
% for i=1:numel(path_to_cellCommands)
% load([path_to_cellCommands{i} '.mat']);
% str_split=cellfun(@(x) regexpi(x,' ','split'),cellCommands,'UniformOutput',0);
% str_split=cellfun(@(x) x{end},str_split,'UniformOutput',0);
% bin=cellfun(@(x) exist(x,'file'),str_split,'UniformOutput',0);
% bin=cell2mat(bin);
% bin=bin>0;
% cellCommands=cellCommands(bin);
% save([path_to_cellCommands{i} '.mat'],'cellCommands');
% end
% end
% 
% return
load('path_to_cellCommands_best_list_diversity.mat','path_to_cellCommands');
load('path_to_cellCommands_best_list_neighbours_diversity.mat',...
    'path_to_cellCommands_neighbours');

executeMatFiles( path_to_cellCommands );
executeMatFiles( path_to_cellCommands_neighbours );

% load('path_to_cellCommands_best_list.mat','path_to_cellCommands');
% load('path_to_cellCommands_best_list_neighbours.mat',...
%     'path_to_cellCommands_neighbours');
% executeMatFiles( path_to_cellCommands );
% executeMatFiles( path_to_cellCommands_neighbours );



