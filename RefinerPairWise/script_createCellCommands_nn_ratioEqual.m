ccc
load('swapAllCombos_unique_10_gt_writeAndScoreLists.mat');
load('models_with_txt.mat');
models=cellfun(@(x) [x '.txt'],models,'UniformOutput',0);

cellCommands_split=cellfun(@(x) regexpi(x,'/','split'),cellCommands,'UniformOutput',0);
cellCommands_split=cellfun(@(x) x{end},cellCommands_split,'UniformOutput',0);

idx=cell2mat(cellfun(@(x) find(strcmp(x,cellCommands_split)),models,'UniformOutput',0));
cellCommands_rel=cellCommands(idx);

cellCommands_rel=cellfun(@(x) strrep(x,'swapPairWiseBeds','renderLists'),cellCommands_rel,'UniformOutput',0);
cellCommands_rel=cellfun(@(x) strrep(x,'swapAllCombos_unique_10_gt_writeAndScoreLists',...
    'swapAllCombos_nn_bestList'),cellCommands_rel,'UniformOutput',0);

cellCommands_rel=cellfun(@(x) strrep(x,'swapAllCombos_unique_10_gt_writeFloorOverlap_html/list_files',...
    'swapAllCombos_unique_10_gt_writeAndScoreLists_html/best_lists_txt'),cellCommands_rel,'UniformOutput',0);

cellCommands=cellCommands_rel;

save('swapAllCombos_nn_bestList.mat','cellCommands');
copyfile('swapAllCombos_nn_bestList.mat','/lustre/maheenr/Image-Modeling/MATLAB_for_visu/swapAllCombos_nn_bestList.mat');

