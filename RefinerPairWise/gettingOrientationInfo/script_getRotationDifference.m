ccc

cam_dir_meta='/lustre/maheenr/cube_per_cam_regenerate';
cams=dir(fullfile(cam_dir_meta,'room3D*'));
cams={cams(:).name};

gt_dir=fullfile(cam_dir_meta,cams{end},'gt_record');
load(fullfile(gt_dir,'record_gt.mat'),'record_gt');

load(fullfile(gt_dir,'record_dpm_with_map.mat'),'record_dpm');

dir_accu_pre=fullfile(cam_dir_meta,cams{end},'processing_lists');
dir_accu_str='dpm_accu_per_mod_linReg_varyingRatio_by_prec_withCat_noOrder_';
dirs_accu=dir(fullfile(dir_accu_pre,[dir_accu_str '*']));
dirs_accu={dirs_accu(:).name};


ids_dpm={record_dpm(:).id};
ids_gt={record_gt(:).id};

for dir_no=1:numel(dirs_accu)
    dir_accu_curr=fullfile(dir_accu_pre,dirs_accu{dir_no});
    models=dir(fullfile(dir_accu_curr,'*.mat'));
    for model_no=1:numel(models)
        
        fprintf('model_no %d\n',model_no);
        accu=load(fullfile(dir_accu_curr,models(model_no).name));
        accu=accu.record_accuracy;
        id=models(model_no).name;
        
        id=id(1:end-4);
        id_cut=regexpi(id,'#','split');
        id_cut=id_cut{end};
        
        idx_gt=find(strcmp(id,ids_gt));
        idx_dpm=find(strcmp(id_cut,ids_dpm));
        
        rec_dpm=record_dpm(idx_dpm);
        rec_gt=record_gt(idx_gt);
        
        map=rec_dpm.gt_skp_map;
        gt_group=rec_gt.groups;
        gt_rots=rec_gt.orients;
        pred_rots=accu.rots;
        quad=rec_gt.quad;
        
        [rot_diff]=getRotationDifference(map,gt_group,gt_rots,pred_rots,dpm_thresh,quadrant);
        
    end
end
