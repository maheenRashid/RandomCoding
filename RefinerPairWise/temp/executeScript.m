clear all; close all; clc;
% load('folders_for_execute_script.mat','mat_files');
load('folders_for_execute_script_neighbours.mat','mat_files');
folders=mat_files;
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
