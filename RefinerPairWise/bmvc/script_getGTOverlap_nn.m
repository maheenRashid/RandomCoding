ccc

dir_parent_meta='/lustre/maheenr/cube_per_cam_regenerate';

dir_in=fullfile(dir_parent_meta,'room3D_auto');

dir_in=fullfile(dir_parent_meta,'room3D_gt');
dir_rendering='nn_render';

dir_masks=fullfile(dir_in,[dir_rendering '_html'],'record_masks');

models=dir(fullfile(dir_masks,'*sun*.mat'));
models={models(:).name};

load('record_gt.mat');
ids_gt={record_gt(:).id};

matlabpool open;
parfor model_no=1:numel(models)
    fprintf('%d\n',model_no);
    masks=load(fullfile(dir_masks,models{model_no}));
    record_masks=masks.record_masks;
    idx=find(strcmp(models{model_no}(1:end-4),ids_gt));
    if isempty(idx)
        fprintf('continuing\n');
        continue;
    end
    rec_gt=record_gt(idx);
    polys_gt=rec_gt.polys;
    cats_gt=rec_gt.labels;
    if numel(record_masks.masks)==0
        continue;
    end
    os_pix=getPairwisePixelOverlap(polys_gt,record_masks.masks,[0,1],size(record_masks.masks{1}));
    boxes_gt=rec_gt.boxes;
    boxes_pred=record_masks.boxes;
    os_box=getosmatrix_bb(cell2mat(boxes_gt'),cell2mat(boxes_pred'));
    
    record_masks.cats_gt=cats_gt;
    record_masks.os_pix=os_pix;
    record_masks.os_box=os_box;
    
    out_file_name=fullfile(dir_masks,[models{model_no}]);
    parsave_name(out_file_name,record_masks,'record_masks');
    
end
matlabpool close;

