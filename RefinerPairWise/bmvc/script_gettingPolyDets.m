ccc

dir_parent_meta='/lustre/maheenr/cube_per_cam_regenerate';

% dir_in=fullfile(dir_parent_meta,'room3D_auto');
% dir_proc='processing_lists_noprune_noNeg';

dir_in=fullfile(dir_parent_meta,'room3D_gt');
dir_proc='processing_lists_noprune_noNeg_all';


best_lists=dir(fullfile(dir_in,dir_proc,'best_list_varying_by_prec_withCat_noOrder*'));
best_lists={best_lists(:).name};

for list_no=5
%     1:7
%     numel(best_lists)
    dir_rendering=best_lists{list_no};
    out_dir=fullfile(dir_in,[dir_rendering '_html'],'record_masks');
%     if ~exist(out_dir,'dir')
%         mkdir(out_dir);
%     else
%         continue;
%     end
    
    models=dir(fullfile(dir_in,dir_rendering));
    models={models(3:end).name};
    
    cat_mask_name='list_best_pred_raw_cat.png';
    box_mask_name='list_best_pred_raw_box.png';
    
    matlabpool open;
    parfor model_no=1:numel(models)
        fprintf('%d\n',model_no);
        curr_dir=fullfile(dir_in,dir_rendering,models{model_no},'renderings');
        im_cat_name=fullfile(curr_dir,cat_mask_name);
        
        if ~exist(im_cat_name,'file')
            continue;
        end
        
        im_box=double(imread(fullfile(curr_dir,box_mask_name)));
        box_nos=unique(im_box(:));
        box_nos(box_nos==0)=[];
        im_cat=double(imread(fullfile(curr_dir,cat_mask_name)));
        cats=zeros(size(box_nos));
        
        masks=cell(size(box_nos));
        for cat_no=1:numel(box_nos)
            cat=im_cat(im_box==box_nos(cat_no));
            cat=mode(cat(:));
            cats(cat_no)=cat;
            masks{cat_no}=im_box==box_nos(cat_no);
        end
        
        record_masks=struct();
        record_masks.id=models{model_no};
        record_masks.cats=cats;
        record_masks.box_nos=box_nos;
        record_masks.masks=masks;
        record_masks.boxes=getBoxesFromMasks(masks);
        out_file_name=fullfile(out_dir,[models{model_no} '.mat']);
        parsave_name(out_file_name,record_masks,'record_masks');
    end
    matlabpool close;
    
end
