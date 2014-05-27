ccc

str='b#bedroom#sun_aaiuzbtklnxpvzbv';
load('gt_list_and_fold.mat');

idx=find(strcmp(str,gt_list));
fold=gt_fold(idx);
gt_rel=gt_list(gt_fold==fold);
names_cut=cellfun(@(x) x(1:end-4),names,'UniformOutput',0);
[names_rel,idx_gt,idx_dir]=intersect(gt_rel,names_cut);
names=names(idx_dir);


return
ccc

cam_dir_meta='/lustre/maheenr/cube_per_cam_regenerate';
gt_dir='room3D_gt';
in_dir=fullfile(cam_dir_meta,gt_dir);
load(fullfile(in_dir,'cubes_record_with3D.mat'));
load(fullfile(in_dir,'boxes_rec_all_new.mat'));
dir_lists=fullfile(in_dir,'processing_lists','record_lists_feature_vecs_withCat_by_prec_withCat_noOrder_0.099759');
dir_dpm=fullfile(in_dir,'processing_lists','dpm_accu_per_mod_linReg_by_prec_withCat_noOrder_0.099759');
dir_results=fullfile(in_dir,'processing_lists','results_linReg_LOO_ratioEqual_test_by_prec_withCat_noOrder_0.099759');
dir_rec_box=fullfile(in_dir,['record_box_info_top_1']);


im_name='b#bedroom#sun_aaiuzbtklnxpvzbv';
im_name_cut=regexpi(im_name,'#','split');
im_name_cut=im_name_cut{end};


list=load(fullfile(dir_lists,[im_name '.mat']));
dpm=load(fullfile(dir_dpm,[im_name '.mat']));
res=load(fullfile(dir_results,[im_name '.mat']));
rec=load(fullfile(dir_rec_box,[im_name '.mat']));

ids_cube={cubes_record(:).id};
ids_box={boxes_rec_all(:).id};
idx_cube=find(strcmp(im_name_cut,ids_cube));
idx_box=find(strcmp(im_name,ids_box));

cube_curr=cubes_record(idx_cube);
box_curr=cubes_record(idx_box);



return
% ccc
% 
% gt_path_pre='/lustre/maheenr/cube_per_cam_regenerate/room3D_gt/processing_lists';
% auto_path_pre='/lustre/maheenr/3dgp_results/swap_in_box_auto_listsScores_1_rerun_html';
% dpm_path='dpm_accu_compiled_linReg_by_prec_withCat_noOrder_0.099759';
% mat_file='prec_recall_compiled.mat';
% 
% gt_mat=load(fullfile(gt_path_pre,dpm_path,mat_file));
% auto_mat=load(fullfile(auto_path_pre,dpm_path,mat_file));
% 
% 
% gt_mat=gt_mat.prec_recall;
% auto_mat=auto_mat.prec_recall;
% 
% a=find(cellfun(@isempty,{auto_mat(:).id}));
% auto_mat(a)=[];
% 
% [~,gt_idx,auto_idx]=intersect({gt_mat(:).id},{auto_mat(:).id});
% gt_mat=gt_mat(gt_idx);
% auto_mat=auto_mat(auto_idx);
% 
% cell_structs={gt_mat,auto_mat};
% 
% cell_recalls=cell(size(cell_structs));
% for i=1:numel(cell_structs)
%     nn_recall={cell_structs{i}(:).nn_dpm};
%     nn_recall=cellfun(@(x) x(3)/x(4),nn_recall);
%     cell_recalls{i}=nn_recall;
% end
% 
% [~,sort_idx]=sort(cell_recalls{2},'descend');
% auto_sorted=auto_mat(sort_idx);
% gt_sorted=gt_mat(sort_idx);

% models={auto_sorted(:).id};
% models=cellfun(@(x) x(1:end-4),models,'UniformOutput',0);
% params.models=models;
% params.dir_n='swap_in_box_auto_bestLists_linReg_0.099759';
% params.dir_n='best_lists_0.099759_fixedQuad';
% params.dir_model='best_lists_0.099759';
% params.in_dir_pre_n='/lustre/maheenr/3dgp_results/swap_in_box_auto_bestLists_linReg_0.099759_rerun';
% params.in_dir_pre_n_html='/3dgp_results/swap_in_box_auto_bestLists_linReg_0.099759_rerun';
% 
% params.in_dir_pre_n='/lustre/maheenr/cube_per_cam_regenerate/room3D_gt/best_lists_0.099759_fixedQuad/';
% params.in_dir_pre_n_html='/cube_per_cam_regenerate/room3D_gt/best_lists_0.099759_fixedQuad/';
% 
% 
% 
% params.in_dir_pre='/lustre/maheenr/cube_per_cam_regenerate/room3D_gt/';
% params.in_dir_pre_html='/cube_per_cam_regenerate/room3D_gt/';
% params.str_pre={'list_best_pred'};
% params.str_post={'_overlay','_overlay_2','_normal','_floor'};
% params.str_pre_nn={'list_best_pred'};
% params.str_post_nn={'_overlay','_overlay_2','_normal','_floor'};
% params.html_name='comp_with_gt_quad.html';
% params.keepFullID=1;
% 

% models={'b#bedroom#sun_aacglewqjbbpfkan',...
%     'b#bedroom#sun_aathajvxrgptwhoj',...
%     'b#bedroom#sun_aaajwnfblludyasb',...
%     'b#bedroom#sun_aacyfyrluprisdrx'};
% 
% params.models=models;
% params.dir_n='3D_cubes';
% params.dir_model='3D_cubes';
% params.in_dir_pre_n='/lustre/maheenr/cube_per_cam_regenerate/room3D_gt/sanity_check/';
% params.in_dir_pre_n_html='/cube_per_cam_regenerate/room3D_gt/sanity_check/';
% params.in_dir_pre='/lustre/maheenr/cube_per_cam_regenerate/room3D_gt/';
% params.in_dir_pre_html='/cube_per_cam_regenerate/room3D_gt/';
% params.str_pre={'/'};
% files=dir(fullfile(params.in_dir_pre_n,models{1},'renderings','*.png'));
% files={files(:).name};
% files=cellfun(@(x) x(1:end-4),files,'UniformOutput',0);
% params.str_post=files;
% params.str_pre_nn=params.str_pre;
% params.str_post_nn=params.str_post;
% params.html_name='sanity_check_gt_quad.html';
% params.keepFullID=1;
% 
% [out_file_name]=writeHTML(params,1)




params.dir_model='sanity_check';
params.in_dir_pre='/lustre/maheenr/cube_per_cam_regenerate/room3D_gt/';
params.in_dir_pre_html='/cube_per_cam_regenerate/room3D_gt/';
params.str_pre={'/'};
files=dir(fullfile(params.in_dir_pre_n,models{1},'renderings','each_rep_*_overlay_2.png'));
files={files(:).name};
files=cellfun(@(x) x(1:end-4),files,'UniformOutput',0);
% params.str_post=files;
params.str_post={'each_rep_000_overlay_2','boxPts_final_000'}
params.html_name='sanity_check_gt_quad_2.html';

[out_file_name]=writeHTML(params)