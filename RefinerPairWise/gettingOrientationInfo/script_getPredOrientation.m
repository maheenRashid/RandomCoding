ccc

n=1;
out_dir=['record_box_info_top_' num2str(n)];
box_dir=fullfile('/lustre/maheenr/cube_per_cam_regenerate/room3D_gt',out_dir);

dir_parent='/lustre/maheenr/cube_per_cam_regenerate/room3D_gt/processing_lists';
dpm_pre='dpm_accu_per_mod_linReg_by_prec_withCat_noOrder_';
list_pre='record_lists_feature_vecs_withCat_by_prec_withCat_noOrder_';
result_pre='results_linReg_LOO_ratioEqual_test_by_prec_withCat_noOrder_';

prec_postfix=dir(fullfile(dir_parent,...
    [dpm_pre '*']));
prec_postfix={prec_postfix(:).name};
prec_postfix=cellfun(@(x) regexpi(x,'_','split'),prec_postfix,'UniformOutput',0);
prec_postfix=cellfun(@(x) x{end},prec_postfix,'UniformOutput',0);


for prec_no=1
    fprintf('prec_no %d of %d\n',prec_no,numel(prec_postfix));
    dpm_dir=fullfile(dir_parent,[dpm_pre prec_postfix{prec_no}]);
    list_dir_spec=fullfile(dir_parent,[list_pre prec_postfix{prec_no}]);
    res_dir_spec=fullfile(dir_parent,[result_pre prec_postfix{prec_no}]);
    
    models=dir(fullfile(dpm_dir,'*.mat'));
    for model_no=1:numel(models)
        fprintf('model_no %d\n',model_no);
        list=load(fullfile(list_dir_spec,models(model_no).name));
        box_info=load(fullfile(box_dir,models(model_no).name));
        
        a=list.record_lists.idx_on_ground;
        b=list.record_lists.box_nos;
        a=a+1;b=b+1;a_b=a(b);
%         
%         list_idx=res.record_lists.best_list_idx_pred;
%         list_chosen=list.record_lists.lists{list_idx};
%         list_chosen=list_chosen+1;
%         
%         idx_chosen=a_b(list_chosen);
%         rec_accu=dpm.record_accuracy.dpm_bin(idx_chosen);
%         cat_chosen=dpm.record_accuracy.cats(idx_chosen);
        
        cats_list=list.record_lists.cat_nos;
        
        rots=zeros(numel(cats_list),1);
        cats=zeros(numel(cats_list),1);
        swap_info=box_info.record_box_info_all.swap_info;
        box_check=swap_info(2:end,1);
        box_check=box_check+1;
        box_check=a(box_check);
        rots_check=swap_info(2:end,4);
        cats_check=swap_info(2:end,3);
        rots(box_check)=rots_check;
        cats(box_check)=cats_check;
        
    end
end