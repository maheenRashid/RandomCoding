
ccc
cam_dir_meta='/lustre/maheenr/cube_per_cam_regenerate';
cams=dir(fullfile(cam_dir_meta,'room3D*'));
cams={cams(:).name};
out_dir=fullfile(cam_dir_meta,cams{end},'gt_record');
load(fullfile(out_dir,'record_gt.mat'),'record_gt');

n=1;
out_dir=['record_box_info_top_' num2str(n)];
box_dir=fullfile(cam_dir_meta,cams{end},out_dir);


% load('models_rel.mat','models_rel','rec_cat','cat_no');
load('models_rel.mat','rec_cat');
cat_no=2;
cats={rec_cat(:).cats};
accus={rec_cat(:).accu};

accus_rel=cellfun(@(x,y) x(y==cat_no),accus,cats,'UniformOutput',0);
bin_emp=cellfun(@isempty,accus_rel);
bin_rel=cellfun(@(x) isequal(x,ones(size(x))),accus_rel);
bin_rel(bin_emp)=0;
models_rel={rec_cat(:).id};
models_rel=models_rel(bin_rel);



ids_gt={record_gt(:).id};
[~,idx,idx_b]=intersect(ids_gt,models_rel);

models_rel=models_rel(idx_b);
gt_rel=record_gt(idx);

quad_orient=zeros(2,numel(gt_rel));
for i=1:numel(gt_rel)
    fprintf('%d\n',i);
    o=gt_rel(i).orients;
    c=gt_rel(i).cats;
    q=gt_rel(i).quad;
    c_o=o(c==cat_no);
    try
        quad_orient(1,i)=c_o;
        quad_orient(2,i)=q;
    catch err
        fprintf('ERROR\n');
        continue;
    end
end

dummy=cell(size(models_rel));
pred_info=struct('id',models_rel,'rot',dummy,'cat',dummy,'box_ids',dummy);
for i=1:numel(models_rel)
    fprintf('%d\n',i);
    load(fullfile(box_dir,models_rel{i}));
    sw_info=record_box_info_all.swap_info;
    rot=sw_info(:,4);
    cat=sw_info(:,3);
    pred_info(i).rot=rot;
    pred_info(i).cat=cat;
    pred_info(i).box_ids=record_box_info_all.box_ids;
end

ids_rec_cat={rec_cat(:).id};
[~,idx]=intersect(ids_rec_cat,models_rel);
rec_cat_rel=rec_cat(idx);


%sanity check 
%this worked out
% s_check=cell(2,size(rec_cat_rel));
% for i=1:numel(s_check)
%     cat=pred_info(i).cat;
%     idx=rec_cat_rel(i).idx_obj;
%     boxes=rec_cat_rel(i).box_nos_plus_one(idx);
%     boxes=boxes-1;
%     [~,idx]=intersect(pred_info(i).box_ids,boxes);
%     s_check{i}=cat(idx)';
% end
% 
% check=cellfun(@(x,y) isequal(x,y),s_check,{rec_cat_rel(:).cats});
% sum(check)
% numel(check)

%get predicted rots too
pred_info_rel=pred_info;
for i=1:numel(pred_info)
    cat=pred_info(i).cat;
    rot=pred_info(i).rot;
    idx=rec_cat_rel(i).idx_obj;
    boxes=rec_cat_rel(i).box_nos_plus_one(idx);
    boxes=boxes-1;
    [~,idx]=intersect(pred_info(i).box_ids,boxes);
    pred_info_rel(i).cat=cat(idx);
    pred_info_rel(i).rot=rot(idx);
end


%find eg of quad orient = x
% quad_orient=zeros(2,numel(gt_rel));
%  quad_orient(1,i)=c_o;
%         quad_orient(2,i)=q;
q_check=4;
idx=find(quad_orient(2,:)==q_check);
orients_gt=quad_orient(1,idx);
cats_pred={pred_info_rel(:).cat};
cats_idx=cellfun(@(x) find(x==cat_no),cats_pred,'UniformOutput',0);
rots_pred_rel=cellfun(@(x,y) x(y(1)),{pred_info_rel(:).rot},...
                cats_idx,'UniformOutput',0);

rots_pred_rel=cell2mat(rots_pred_rel);
rots_pred_rel=rots_pred_rel(idx);

ids=gt_rel(idx);
ids={ids(:).id};


for gt_rot=1:4
    fprintf('GT_ROT: %d\n',gt_rot)
    id_rel=ids(orients_gt==gt_rot);
    rots_curr=rots_pred_rel(orients_gt==gt_rot);
    for i=1:numel(id_rel)
        fprintf('%s  pred_rot:%d\n',id_rel{i},rots_curr(i))
        pause;
    end
end


