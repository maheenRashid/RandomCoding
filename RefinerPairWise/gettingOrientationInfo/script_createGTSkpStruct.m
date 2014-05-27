ccc
cam_dir_meta='/lustre/maheenr/cube_per_cam_regenerate';
cams=dir(fullfile(cam_dir_meta,'room3D*'));
cams={cams(:).name};

out_dir='gt_renderingAndQuad';
models=dir(fullfile(cam_dir_meta,cams{end},out_dir));
models={models(3:end).name};

rendering_dir='/home/maheenr/results_temp_09_13/gt_raw_check_new_labels_2';
cat_dir='/home/maheenr/dataNew/skp_category_correct';
groupings_dir='/home/maheenr/AWS-DATA/data/shared_payload/annotated_models/skp_groupings';
orient_dir='/home/maheenr/dataNew/perModelOrientFiles_GT'

record_gt=struct('id',models,'quad',cell(size(models)),...
    'cats',cell(size(models)),'orients',cell(size(models)),...
    'groups',cell(size(models)),'boxes',cell(size(models)));

for i=1:numel(record_gt)
    fprintf('%d of %d\n',i,numel(record_gt));
    id=record_gt(i).id;
    record_gt(i)=getGTStruct(id,rendering_dir,cat_dir,groupings_dir,orient_dir);
end

out_dir=fullfile(cam_dir_meta,cams{end},'gt_record');
if ~exist(out_dir,'dir')
    mkdir(out_dir)
end
save(fullfile(out_dir,'record_gt.mat'),'record_gt');
