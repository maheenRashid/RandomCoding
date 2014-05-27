ccc

dir_parent='/lustre/maheenr/cube_per_cam_regenerate/'

cam_dir='room3D_auto';
proc_dir='processing_lists_noprune_noNeg';

cam_dir='room3D_gt';
proc_dir='processing_lists_noprune_noNeg_all';

dir_parent=fullfile(dir_parent,cam_dir,proc_dir);
dpm_pre='dpm_accu_per_mod_linReg_varyingRatio_by_prec_withCat_noOrder_';
list_pre='record_lists_feature_vecs_withCat_by_prec_withCat_noOrder_';

prec_postfix=dir(fullfile(dir_parent,...
    [dpm_pre '*']));
prec_postfix={prec_postfix(:).name};
prec_postfix=cellfun(@(x) regexpi(x,'_','split'),prec_postfix,'UniformOutput',0);
prec_postfix=cellfun(@(x) x{end},prec_postfix,'UniformOutput',0);


for prec_no=1:numel(prec_postfix)
    fprintf('prec_no %d of %d\n',prec_no,numel(prec_postfix));
    dpm_dir=fullfile(dir_parent,[dpm_pre prec_postfix{prec_no}]);
    list_dir_spec=fullfile(dir_parent,[list_pre prec_postfix{prec_no}]);
    
    models=dir(fullfile(dpm_dir,'*.mat'));
    matlabpool open;
    parfor model_no=1:numel(models)
        list=load(fullfile(list_dir_spec,models(model_no).name));
        dpm=load(fullfile(dpm_dir,models(model_no).name));
        out_file_name=fullfile(dpm_dir,models(model_no).name);
        cats=list.record_lists.cat_nos;
        thresh_bin=list.record_lists.dpm_thresh_bin;
        cats_new=cats(thresh_bin(2:end));
        dpm.record_accuracy.cats=cats_new;
        parsave_name(out_file_name,dpm.record_accuracy,'record_accuracy');
    end
    matlabpool close;
end