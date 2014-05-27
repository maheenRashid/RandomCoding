
ccc

dir_parent='/lustre/maheenr/cube_per_cam_regenerate/room3D_gt/processing_lists';

% dpm_pre='dpm_accu_per_mod_linReg_by_prec_withCat_noOrder_';
dpm_pre='dpm_accu_per_mod_linReg_varyingRatio_by_prec_withCat_noOrder_';
list_pre='record_lists_feature_vecs_withCat_by_prec_withCat_noOrder_';

gt_dir=fullfile('/lustre/maheenr/cube_per_cam_regenerate/room3D_gt',...
    'gt_record');
load(fullfile(gt_dir,'record_pred_orientation_1.mat'),'record_orient');


prec_postfix=dir(fullfile(dir_parent,...
    [dpm_pre '*']));
prec_postfix={prec_postfix(:).name};
prec_postfix=cellfun(@(x) regexpi(x,'_','split'),prec_postfix,'UniformOutput',0);
prec_postfix=cellfun(@(x) x{end},prec_postfix,'UniformOutput',0);

ids_orient={record_orient(:).id};

for prec_no=1:numel(prec_postfix)
    fprintf('prec_no %d of %d\n',prec_no,numel(prec_postfix));
    dpm_dir=fullfile(dir_parent,[dpm_pre prec_postfix{prec_no}]);
    list_dir_spec=fullfile(dir_parent,[list_pre prec_postfix{prec_no}]);
    
    models=dir(fullfile(dpm_dir,'*.mat'));
%     matlabpool open;
%     par
    for model_no=1:numel(models)
        fprintf('%d\n',model_no);
        list=load(fullfile(list_dir_spec,models(model_no).name));
        dpm=load(fullfile(dpm_dir,models(model_no).name));
        
        id=models(model_no).name;
        id=id(1:end-4);
        idx=find(strcmp(id,ids_orient));
        rots=record_orient(idx).rots;
        
        out_file_name=fullfile(dpm_dir,models(model_no).name);
        cats=list.record_lists.cat_nos;
        thresh_bin=list.record_lists.dpm_thresh_bin;
        thresh_bin=thresh_bin(2:end);
        
        cats_new=cats(thresh_bin);
        rots_new=rots(thresh_bin);
        
        dpm.record_accuracy.cats=cats_new;
        dpm.record_accuracy.rots=rots_new;
        dpm.record_accuracy.thresh_bin=thresh_bin;
        
        parsave_name(out_file_name,dpm.record_accuracy,'record_accuracy');
    end
%     matlabpool close;
end