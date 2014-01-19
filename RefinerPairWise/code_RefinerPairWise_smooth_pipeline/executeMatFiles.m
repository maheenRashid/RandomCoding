function executeMatFiles( folders )
%UNTITLED21 Summary of this function goes here
%   Detailed explanation goes here

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

end

