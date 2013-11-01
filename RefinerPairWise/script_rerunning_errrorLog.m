ccc


dir_commands='/lustre/maheenr/Image-Modeling/MATLAB_for_visu';
folders_cmd={'swapAllCombos_unique_10_gt_writeAndScoreLists','swapAllCombos_unique_10_auto_writeAndScoreLists'};

dir_parent='/home/maheenr/results_temp_09_13';
folders={'swapAllCombos_unique_10_auto_writeFloorOverlap',...
    'swapAllCombos_unique_10_gt_writeFloorOverlap'};

for folder_no=1:numel(folders)
    folder=folders{folder_no};
    out_dir=fullfile(dir_parent,[folder '_html'],'list_files');
    auto_or_gt=regexpi(folder,'_','split');
    auto_or_gt=auto_or_gt{4};
    folders_cmd_curr=folders_cmd{~cellfun(@isempty,strfind(folders_cmd,auto_or_gt))};
    
    load(fullfile(dir_commands,[folders_cmd_curr '.mat']))
    load(fullfile(out_dir,'errorLog_lists.mat'),'errorLog_lists');
    im_names={errorLog_lists(:).name};
    
    cellCommands_cmp=cellfun(@(x) x{end},cellfun(@(x) regexpi(x,' ','split'),cellCommands,'UniformOutput',0),'UniformOutput',0);
    
    matlabpool open
    parfor i=1:numel(im_names)
        i
        idx=find(~cellfun(@isempty,strfind(cellCommands_cmp,im_names{i})));
        if numel(idx)>1
            keyboard;
        else
            system([cellCommands{idx} '>output.txt']);
        end
    end
    matlabpool close
end
