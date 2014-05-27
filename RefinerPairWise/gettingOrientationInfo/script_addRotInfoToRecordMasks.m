ccc

dir_parent_meta='/lustre/maheenr/cube_per_cam_regenerate';

% dir_in=fullfile(dir_parent_meta,'room3D_auto');
% dir_proc='processing_lists_noprune_noNeg';

dir_in=fullfile(dir_parent_meta,'room3D_gt');
dir_proc='processing_lists_noprune_noNeg_all';

dir_lists=fullfile(dir_in,dir_proc,'record_lists');
dir_box=fullfile(dir_in,'record_box_info_top_1');

best_lists=dir(fullfile(dir_in,dir_proc,'best_list_varying_by_prec_withCat_noOrder*'));
best_lists={best_lists(:).name};

for list_no=1:7
%     numel(best_lists)
    dir_rendering=best_lists{list_no};
    dir_masks=fullfile(dir_in,[dir_rendering '_html'],'record_masks');
    
    models=dir(fullfile(dir_masks,'*sun*.mat'));
    models={models(:).name};
    
    matlabpool open;
    parfor model_no=1:numel(models)
        fprintf('%d of %d\n',model_no,numel(models));
        
        record_box=load(fullfile(dir_box,models{model_no}));
        record_box=record_box.record_box_info_all;
        
        record_lists=load(fullfile(dir_lists,models{model_no}));
        record_lists=record_lists.record_lists;
        
        record_masks=load(fullfile(dir_masks,models{model_no}));
        record_masks=record_masks.record_masks;
        
        box_nos=record_lists.box_nos(record_masks.box_nos);
        swap_info=record_box.swap_info;
        rots=zeros(size(box_nos));
        for i=1:numel(rots)
            idx=swap_info(:,1)==box_nos(i);
            rots(i)=swap_info(idx,4);
        end
        record_masks.orients=rots;
        parsave_name(fullfile(dir_masks,models{model_no}),record_masks,'record_masks');
    end
    matlabpool close;
    
end