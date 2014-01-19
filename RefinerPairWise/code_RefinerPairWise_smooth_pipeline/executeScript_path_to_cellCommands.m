clear all; close all; clc;
% load('folders_for_execute_script.mat','mat_files');
load('path_to_cellCommands_best_list.mat','path_to_cellCommands');
folders=path_to_cellCommands;
for folder_no=1:numel(folders)
    folder=folders{folder_no};
    load([folder '.mat'],'cellCommands');
%     folder
%     continue
    for i=1:numel(cellCommands)
        currDir=regexpi(cellCommands{i},' ','split');
        currDir=currDir{3};
        if ~exist(currDir,'dir')
            mkdir(currDir);
            system(cellCommands{i});
        end
    end
end
