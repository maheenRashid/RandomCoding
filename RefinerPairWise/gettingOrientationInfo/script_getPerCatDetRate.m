ccc


dir_parent_meta='/lustre/maheenr/cube_per_cam_regenerate';

dir_in=fullfile(dir_parent_meta,'room3D_auto');
dir_rendering='best_list_varying_by_prec_withCat_noOrder_0.099759';
dir_masks=fullfile(dir_in,[dir_rendering '_html'],'record_masks');

models=dir(fullfile(dir_masks,'*.mat'));
models={models(:).name};


cat_no=1;
det_record=struct('id',models,'det_overlap',cell(size(models)));
for model_no=1:numel(models)
    masks=load(fullfile(dir_masks,models{model_no}));
    record_masks=masks.record_masks;
    if ~isfield(record_masks,'os_pix')
        continue;
    end
    
    idx_gt=find(record_masks.cats_gt==cat_no);
    idx_pred=find(record_masks.cats~=cat_no);
    os_pix=record_masks.os_pix;
    os_pix(:,idx_pred)=0;
    
    overlap=os_pix(idx_gt,:);
    ovelap_max=max(overlap,[],2);
    
    keyboard;

end