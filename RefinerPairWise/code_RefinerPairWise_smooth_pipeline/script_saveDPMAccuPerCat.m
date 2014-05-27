ccc

dir_parent='/lustre/maheenr/cube_per_cam_regenerate/';

cam_dir='room3D_auto';
proc_dir='processing_lists_noprune_noNeg';

dir_parent=fullfile(dir_parent,cam_dir,proc_dir);
dpm_pre='dpm_accu_per_mod_linReg_varyingRatio_by_prec_withCat_noOrder_';
list_pre='record_lists_feature_vecs_withCat_by_prec_withCat_noOrder_';

out_dir_pre='dpm_accu_compiled_per_cat_';


prec_postfix=dir(fullfile(dir_parent,...
    [dpm_pre '*']));
prec_postfix={prec_postfix(:).name};
prec_postfix=cellfun(@(x) regexpi(x,'_','split'),prec_postfix,'UniformOutput',0);
prec_postfix=cellfun(@(x) x{end},prec_postfix,'UniformOutput',0);

load('record_gt.mat');
mapping=[1,8,9,2,4];

for cat_idx=1:numel(mapping)
    
    cat_no=mapping(cat_idx);

    for prec_no=1:numel(prec_postfix)
        fprintf('prec_no %d of %d\n',prec_no,numel(prec_postfix));
        dpm_dir=fullfile(dir_parent,[dpm_pre prec_postfix{prec_no}]);
        out_dir=[out_dir_pre num2str(cat_no) '_' prec_postfix{prec_no}];
        out_dir=fullfile(dir_parent,out_dir);
        if ~exist(out_dir,'dir')
            mkdir(out_dir);
        end
        
        models=dir(fullfile(dpm_dir,'*.mat'));
        tmp=cell(1,numel(models));
        prec_recall=struct('id',tmp,'dpm',tmp,'nn_dpm',tmp,'nn_dpm_best',tmp);
        
        for model_no=1:numel(models)
            dpm=load(fullfile(dpm_dir,models(model_no).name));
            id=dpm.record_accuracy.name;
            id=id(1:end-4);
            idx_gt=find(strcmp(id,{record_gt(:).id}));
            rec_gt_curr=record_gt(idx_gt);
            
            prec_recall(model_no)=getPrecRecallStruct_CatSpecific...
                (prec_recall(model_no),dpm.record_accuracy,cat_no,rec_gt_curr.labels);
            prec_recall(model_no).id=id;
            
        end
        out_file_name=fullfile(out_dir,'prec_recall_compiled');
        save(out_file_name,'prec_recall');
        compiled_dirs{prec_no}=out_dir;
    end
    
    out_dir=fullfile(dir_parent,...
        ['prec_recall_curves_mat_images_cat_' num2str(cat_no)]);
    script_savePrecRecallCompiledMatAndImages;
end