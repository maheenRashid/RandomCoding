ccc


load 3dnn_gt.mat;

cellCommands_rep=cellCommands;

old_out_dir='/home/maheenr/results_temp_09_13/3dnn_gt';
new_out_dir='/home/maheenr/cube_per_cam_regenerate/room3D_gt/nn_render';

cellCommands_rep=cellfun(@(x) strrep(x,old_out_dir,new_out_dir),cellCommands_rep,'UniformOutput',0);

cellCommands=cellCommands_rep;
save([new_out_dir '.mat'],'cellCommands');

return

load auto_cellCommands

old_c='swapPairWiseBeds';
new_c='script_renderCatAndGroupRawImages';
old_out_dir='/home/maheenr/results_temp_09_13/swapAllCombos_unique_10_auto_writeAndScoreLists';
new_out_dir='/home/maheenr/cube_per_cam_regenerate/room3D_auto/nn_render';


str_to_find='_norm.txt';

cellCommands_rep=cellCommands;
cellCommands_rep=cellfun(@(x) strrep(x,old_c,new_c),cellCommands_rep,'UniformOutput',0);
cellCommands_rep=cellfun(@(x) strrep(x,old_out_dir,new_out_dir),cellCommands_rep,'UniformOutput',0);
idx=cellfun(@(x) strfind(x,str_to_find),cellCommands_rep);
idx=idx+numel(str_to_find);
idx=num2cell(idx);
cellCommands_rep=cellfun(@(x,y) strrep(x,x(y:end),''),cellCommands_rep,idx,'UniformOutput',0);

cellCommands=cellCommands_rep;
save([new_out_dir '.mat'],'cellCommands');
