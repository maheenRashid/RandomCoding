ccc

dir_orients='/home/maheenr/dataNew/perModelOrientFiles_GT/';
dir_groups='/home/maheenr/AWS-DATA/data/shared_payload/annotated_models/skp_groupings/';
% dir_cats='/home/maheenr/dataNew/skp_category_correct/';

dir_parent_meta='/lustre/maheenr/cube_per_cam_regenerate';
% dir_in=fullfile(dir_parent_meta,'room3D_auto');
dir_in=fullfile(dir_parent_meta,'room3D_gt');

dir_rendering='nn_render';
dir_masks=fullfile(dir_in,[dir_rendering '_html'],'record_masks');

models=dir(fullfile(dir_masks,'*sun*.mat'));
models={models(:).name};

load(fullfile(dir_in,'nn_render.mat'));

match_info=cellfun(@(x) regexpi(x,' ','split'),cellCommands,'UniformOutput',0);
match_info=cellfun(@(x) x([3,5,6]),match_info,'UniformOutput',0);
match_info_easy=cell(numel(match_info),3);
for i=1:numel(match_info)
    match_info_easy(i,:)=[match_info{i}];
end
match_info=match_info_easy;

match_info(:,1)=cellfun(@(x) regexpi(x,'/','split'),match_info(:,1),'UniformOutput',0);
match_info(:,1)=cellfun(@(x) x{end-1},match_info(:,1),'UniformOutput',0);
match_info(:,2)=cellfun(@(x) x(1:end-4),match_info(:,2),'UniformOutput',0);

models_name=cellfun(@(x) x(1:end-4),models,'UniformOutput',0);

for model_no=1:numel(models)
    fprintf('%d of %d\n',model_no,numel(models));
    
    record_masks=load(fullfile(dir_masks,models{model_no}));
    record_masks=record_masks.record_masks;
    
    idx=strcmp(models_name{model_no},match_info(:,1));
    match_name=match_info{idx,2};
    transnum=str2double(match_info{idx,3});
    
    groups_pred=record_masks.box_nos;
    
    groups_txt=fullfile(dir_groups,[match_name '.txt']);
    groups_txt=getVecFromFile(groups_txt);    
    
    orients_txt=fullfile(dir_orients,[match_name '.txt']);
    orients_txt=getVecFromFile(orients_txt);    

    pred_orients=zeros(size(groups_pred));
    for i=1:numel(groups_pred)
        bin=groups_txt==groups_pred(i);
        orients=orients_txt(bin);
        pred_orients(i)=max(orients);
    end
    
    record_masks.orients=pred_orients;
    record_masks.transnum=transnum;
    
    save(fullfile(dir_masks,models{model_no}),'record_masks');
    
end
