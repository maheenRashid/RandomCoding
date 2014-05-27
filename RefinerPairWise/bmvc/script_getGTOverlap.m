ccc

dir_parent_meta='/lustre/maheenr/cube_per_cam_regenerate';

% dir_in=fullfile(dir_parent_meta,'room3D_auto');
% dir_proc='processing_lists_noprune_noNeg';

dir_in=fullfile(dir_parent_meta,'room3D_gt');
dir_proc='processing_lists_noprune_noNeg_all';

best_lists=dir(fullfile(dir_in,dir_proc,'best_list_varying_by_prec_withCat_noOrder*'));
best_lists={best_lists(:).name};

for list_no=4
%     1:7
%     numel(best_lists)
    dir_rendering=best_lists{list_no};
    out_mutex=fullfile(dir_in,[dir_rendering '_html'],'record_masks_ov_mutex');
%     if ~exist(out_mutex,'dir')
%         mkdir(out_mutex);
%     else
%         continue;
%     end
    
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
end
