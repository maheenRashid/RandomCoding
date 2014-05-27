ccc

dir_parent_meta='/lustre/maheenr/cube_per_cam_regenerate';
dir_in=fullfile(dir_parent_meta,'room3D_auto');
gt_dir=fullfile(dir_parent_meta,'room3D_gt','gt_record');

out_dir=fullfile(dir_in,'gt_record');
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end

sun=load('record_gt.mat');
sun=sun.record_gt;

skp=load(fullfile(gt_dir,'record_gt.mat'),'record_gt');
skp=skp.record_gt;

thresh=0.35;

[sun(:).orients]=deal([]);
[sun(:).quad]=deal([]);
[sun(:).groups]=deal([]);

ids_sun={sun(:).id};
for model_no=1:numel(skp)
    fprintf('%d\n',model_no);
    skp_curr=skp(model_no);
    
    id=skp_curr.id;
    
    idx=strcmp(id,ids_sun);
    if sum(idx)==0
        continue;
    end
    sun_curr=sun(idx);
    
    box_skp=skp_curr.boxes;
    box_sun=sun_curr.boxes;
    overlaps=getosmatrix_bb(cell2mat(box_skp),cell2mat(box_sun'));
    
    sun_cat=sun_curr.labels;
    skp_cat=skp_curr.cats;
    sun_orients=zeros(size(sun_cat));
    skp_orients=skp_curr.orients;
    sun_groups=zeros(size(sun_cat));
    skp_groups=skp_curr.groups;
    

    for i=1:numel(sun_cat)
        ov=overlaps(:,i);
        row_keep=1:numel(ov);
        row_keep=skp_cat==sun_cat(i);
        ov(~row_keep)=0;
        ov(ov<thresh)=0;
        [max_val,max_idx]=max(ov);
        if max_val>0
            sun_orients(i)=skp_orients(max_idx);
            sun_groups(i)=skp_groups(max_idx);
        end
    end
    sun(idx).orients=sun_orients;
    sun(idx).quad=skp_curr.quad;
    sun(idx).groups=sun_groups;
end

record_gt=sun;
% save(fullfile(out_dir,'record_gt_sun_with_orients.mat'),'record_gt');

save(fullfile(out_dir,'record_gt_sun_with_orients_group.mat'),'record_gt');
