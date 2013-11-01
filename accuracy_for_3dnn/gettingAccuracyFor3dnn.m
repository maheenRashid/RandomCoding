ccc

meta_dir='E:/RandomCoding/accuracy_for_3dnn';

folders={'E:/RandomCoding/accuracy_for_3dnn/3dnn_gt_html/detections_withBin.mat',...
    'E:/RandomCoding/accuracy_for_3dnn/3dnn_auto_html/detections_withBin.mat',...
    'E:/RandomCoding/downloadingAnnotations/dpm_greater_-1_bbox_record_withDetections.mat'};
str_for_disp={'3dnn_gt','3dnn_auto','dpm'}

for folder_no=1:numel(folders)
    load(folders{folder_no});
    
    
    record_labelMe_ease=cell(5,0);
    for i=1:size(record_labelMe,2)
       cell_det=record_labelMe{2,i};
       if size(cell_det,1)~=4
            continue
       end
       cell_name=cell(1,size(cell_det,2));
       [cell_name{1,:}]=deal(record_labelMe{1,i});
       record_labelMe_ease=[record_labelMe_ease,[cell_name;cell_det]];
    end

    cat_ids=unique(record_labelMe_ease(2,:));
    labs=[0,1];
    accu_mat=zeros(1,numel(cat_ids));
    for cat_no=1:numel(cat_ids)
       idx=strcmp(cat_ids(cat_no),record_labelMe_ease(2,:));
       bin=cellfun(@(x) x>0,record_labelMe_ease(end,idx));
       accu_mat(cat_no)=sum(bin)/numel(bin);
    end
    
    figure;
    bar(accu_mat);
     set(gca,'XTickLabel',cat_ids);
     th=title(str_for_disp{folder_no});
    set(th,'interpreter','none');
end