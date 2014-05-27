ccc

%check how the best list files are written
dir_parent='/lustre/maheenr/cube_per_cam_regenerate/room3D_gt/processing_lists';
res_dir=fullfile(dir_parent,'results_linReg_LOO_ratioEqual_test_by_prec_withCat_noOrder_0.099759');
list_dir=fullfile(dir_parent,'record_lists');
dpm_dir=fullfile(dir_parent,'dpm_accu_per_mod_linReg_by_prec_withCat_noOrder_0.099759');


cat_no=1;

models=dir(fullfile(res_dir,'*.mat'));
models_cut={models(:).name};
models_cut=cellfun(@(x) x(1:end-4),models_cut,'UniformOutput',0);
dummy=cell(size(models_cut));
rec_cat=struct('id',models_cut,'cats',dummy,...
    'accu',dummy,'idx_obj',dummy,...
    'idx_on_ground_plus_one',dummy,'box_nos_plus_one',dummy,...
    'idx_for_dpm_bin',dummy,'dpm_bin_all',dummy);

matlabpool open
parfor model_no=1:10
%     numel(models)
    fprintf('%d\n',model_no);
    res=load(fullfile(res_dir,models(model_no).name));
    list=load(fullfile(list_dir,models(model_no).name));
    dpm=load(fullfile(dpm_dir,models(model_no).name));
    
    list_idx=res.record_lists.best_list_idx_pred;
    list_chosen=list.record_lists.lists{list_idx};
    list_chosen=list_chosen+1;
    cats_chosen= list.record_lists.cat_nos(list_chosen);
    
    a=list.record_lists.idx_on_ground;
    b=list.record_lists.box_nos;
    a=a+1;b=b+1;a_b=a(b);
    
    idx_chosen=a_b(list_chosen);
    rec_accu=dpm.record_accuracy.dpm_bin(idx_chosen);
    rec_cat(model_no).accu=rec_accu;
    rec_cat(model_no).cats=cats_chosen;
    rec_cat(model_no).idx_obj=list_chosen;
    rec_cat(model_no).idx_on_ground_plus_one=a;
    rec_cat(model_no).box_nos_plus_one=b;
    rec_cat(model_no).idx_for_dpm_bin=a_b;
    rec_cat(model_no).dpm_bin_all=dpm.record_accuracy.dpm_bin;
    
end
matlabpool close;

model_no=numel(models);

cats={rec_cat(1:model_no).cats};
accus={rec_cat(1:model_no).accu};

accus_rel=cellfun(@(x,y) x(y==cat_no),accus,cats,'UniformOutput',0);
bin_emp=cellfun(@isempty,accus_rel);
bin_rel=cellfun(@(x) isequal(x,ones(size(x))),accus_rel);
bin_rel(bin_emp)=0;
models_rel={rec_cat(1:model_no).id};
models_rel=models_rel(bin_rel);

save('models_rel.mat');
