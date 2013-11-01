ccc

meta_dir='D:\ResearchCMU\git\Image-Modeling\MATLAB_for_visu\swapModelInBox_sort_refine';
load(fullfile(meta_dir,'swapModelInBox_newLabels_bestSortedByDPMScore_gt_refine.mat'),'cellCommands');


% return

cellCommands_rel=cell(size(cellCommands));
for i=1:numel(cellCommands)
    command_curr=cellCommands{i};
    command_curr=regexpi(command_curr,' ','split');
    command_curr{1}=strrep(command_curr{1},'swapModelInBox_sort_refine','script_getBoxOverlap');
   
    out_dir=command_curr{3};
    slash_idx=strfind(out_dir,'/');
    out_dir_cpy=out_dir(1:slash_idx(end-1));
    out_dir_cpy=[out_dir_cpy '0' out_dir(slash_idx(end-1):end)];
    out_dir_cpy=strrep(out_dir_cpy,'swapModelInBox_newLabels_bestSortedByDPMScore_gt_refine',...
        'swapModel_allBoxes_bestSortedByDPMScore_gt_withText');
    
    command_curr{3}=out_dir_cpy;
    
    command_curr=[command_curr '0'];
    command_curr=sprintf('%s ',command_curr{:});
    command_curr=command_curr(1:end-1);
    cellCommands_rel{i}=command_curr;
    
    
%     keyboard;

end

cellCommands=cellCommands_rel;
save('swapModel_allBoxes_bestSortedByDPMScore_gt_withText1.mat','cellCommands');






return
ccc

meta_dir='E:\RandomCoding\gettingModelsForSwap';

load(fullfile(meta_dir,'visualizing_results','swapModel_moreBoxes_bestSortedByDPMScore_gt_html','relevant_files.mat'),'relevant_files');
load(fullfile(meta_dir,'swapModel_moreBoxes_cellCommands','swapModel_moreBoxes_bestSortedByDPMScore_gt.mat'),'cellCommands');


idx=~cellfun(@isempty,relevant_files(end,:));
relevant_files=relevant_files(:,idx);

for i=1:size(relevant_files,2)
    relevant_files{end,i}=strrep(relevant_files{end,i},'/lustre','/home');
    relevant_files{end,i}=strrep(relevant_files{end,i},'renderings','');
end

cellCommands_rel=cell(size(relevant_files,2),1);
for i=1:size(relevant_files,2)
    idx=~cellfun(@isempty,strfind(cellCommands,relevant_files{end,i}));
    if sum(idx) ~=1
        keyboard;
    end
    
    command_curr=cellCommands{idx};
    command_curr=strrep(command_curr,'swapModelInBox_sort_diffIdx','script_getBoxOverlap');
    command_curr=strrep(command_curr,'swapModel_moreBoxes_bestSortedByDPMScore_gt','swapModel_allBoxes_bestSortedByDPMScore_gt_withText');
    cellCommands_rel{i}=command_curr;


end


cellCommands=cellCommands_rel;
save('swapModel_allBoxes_bestSortedByDPMScore_gt_withText.mat','cellCommands');



