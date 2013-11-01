ccc
load('gt_models_list.mat');
load('3dnn_gt.mat');

file_to_run='/home/maheenr/Image-Modeling/OSMesa-Renderer/script_renderCatAndGroupRawImages';
folder='gt_raw_correct'
out_dir_pre=['/home/maheenr/results_temp_09_13/' folder '/'];
cam_pre='cam:/home/maheenr/AWS-DATA/data/shared_payload/annotated_models/skp_cam/';
transNum='4';
%irrelevant;
fold='/home/maheenr/AWS-DATA/data/feature_weights/MAR_14_2013/fold_2_norm.txt';

cell_commands=cell(numel(gt_models_list),7);
for model_no=1:numel(gt_models_list)
    name=gt_models_list(model_no).name;
    
    for col_no=2:size(cell_commands,2)-1
        switch col_no
            case 2
                str=name(1:end-4);
                str=strrep(str,'#','/');
            case 3
                str=name(1:end-4);
                str=[out_dir_pre str '/'];
            case 4
                str=[cam_pre name];
            case 5
                str=name;
            case 6
                str=transNum;            
        end
        cell_commands{model_no,col_no}=str;
    end
end

[cell_commands{:,1}]=deal(file_to_run);
[cell_commands{:,end}]=deal(fold);

cell_check=cell(numel(cell_commands,1),1);
for i=1:size(cell_commands,1)
cell_check{i}=sprintf('%s ',cell_commands{i,:});
cell_check{i}=cell_check{i}(1:end-1);
end
cellCommands=cell_check;
save([ folder '.mat'],'cellCommands');
