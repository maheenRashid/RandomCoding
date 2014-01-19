ccc

dir_parent='/lustre/maheenr/results_temp_09_13';
file='swapObjectsInBox_allOffsets_sizeComparison_bugFixed_gt';
folder='swapObjectsInBox_allOffsets_sizeComparison_bugFixed_gt_refPW';
c_file_to_run='renderLists';
path_to_text=fullfile(dir_parent,folder,'text_files');
load([file '.mat']);

params.cellCommands=cellCommands;
params.file=file;
params.path_to_text=path_to_text;
params.c_file_to_run=c_file_to_run;

save('gt_cellCommands_struct.mat','params');


% cellCommands=cellCommands.cellCommands;
% cellCommands_rep=createRenderListsMat(cellCommands,c_file_to_run,path_to_text,...
%                                             path_to_bestList,out_name,file)