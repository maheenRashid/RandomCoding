ccc

n=1;
out_dir=['record_box_info_top_' num2str(n)];
box_dir=fullfile('/lustre/maheenr/cube_per_cam_regenerate/room3D_gt',out_dir);
gt_dir=fullfile('/lustre/maheenr/cube_per_cam_regenerate/room3D_gt',...
    'gt_record');


dir_parent='/lustre/maheenr/cube_per_cam_regenerate/room3D_gt/processing_lists';
list_pre='record_lists_feature_vecs_withCat_by_prec_withCat_noOrder_';

prec_postfix=dir(fullfile(dir_parent,...
    [list_pre '*']));
prec_postfix={prec_postfix(:).name};
prec_postfix=cellfun(@(x) regexpi(x,'_','split'),prec_postfix,'UniformOutput',0);
prec_postfix=cellfun(@(x) x{end},prec_postfix,'UniformOutput',0);

prec_no=1;
fprintf('prec_no %d of %d\n',prec_no,numel(prec_postfix));
list_dir_spec=fullfile(dir_parent,[list_pre prec_postfix{prec_no}]);

models=dir(fullfile(list_dir_spec,'*.mat'));
dummy=cell(size(models));
record_orient=struct('id',dummy,'rots',dummy,'cats',dummy);

for model_no=1:numel(models)
    fprintf('model_no %d\n',model_no);
    list=load(fullfile(list_dir_spec,models(model_no).name));
    box_info=load(fullfile(box_dir,models(model_no).name));
    
    a=list.record_lists.idx_on_ground;
    a=a+1;
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
    
    id=models(model_no).name;
    record_orient(model_no).id=id(1:end-4);
    record_orient(model_no).rots=rots;
    record_orient(model_no).cats=cats;
end

save(fullfile(gt_dir,'record_pred_orientation_1.mat'),'record_orient');