
load('gt_cellCommands');
params=struct();
params.c_file='/home/maheenr/Image-Modeling/OSMesa-Renderer/renderLists_cubeMethod_best';
params.out_dir=[out_dir '/'];
text_dirs=cellfun(@(x) [x '/'],text_dirs,'UniformOutput',0);
justNameFlag=[0,0];
params.text_dirs=text_dirs;
params.justNameFlag=justNameFlag;
skp_dir=[fullfile(cam_dir_meta,gt_dir) '/'];
model_names=dir(fullfile(text_dirs{end},'*.txt'));
model_names={model_names(:).name};
model_names=cellfun(@(x) regexpi(x,'[#.]','split'),model_names,'UniformOutput',0);
model_names=cellfun(@(x) x{end-1},model_names,'UniformOutput',0);

[cellCommands]=getCellCommands_cubeMethod(cellCommands,model_names,params);
cellCommands=cellfun(@(x) [x ' ' skp_dir],cellCommands,'UniformOutput',0);
filename=fullfile(cam_dir_meta,gt_dir,[out_dir_ac '.mat']);
save(filename,'cellCommands');