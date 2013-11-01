ccc

% load('dpm_greater_-1_bbox_record_withDetections.mat')
load('dpm_greater_-1_bbox_record_withDetections_multiCat.mat')
load('gt_list.mat')



dir_in_pre='gt_models';
dir_in_post='Img_GT_Features';
dir_in_post_feature='Img_Features'
normal_mask='omapmore.png';
munoz_mask='munoz_clutter_mask.png';
show=0;
windowSize=5;


record=[record;cell(2,size(record,2))];

for gt_no=1:numel(gt_list)
    
    name_curr=gt_list{gt_no};
    if numel(find(strcmp(name_curr,errorLog)))>0
        continue;
    end
    
    name_dpm=regexpi(name_curr,'#','split');
    name_dpm=name_dpm{end};
    dpm_curr=strcmp(name_dpm,record(2,:));
    idx_dpm_curr=find(dpm_curr);
    dpm_curr=record(:,dpm_curr);
    
    cell_features_all=cell(2,numel(idx_dpm_curr));
    
    for dpm_cat_no=1:numel(idx_dpm_curr)
        dpm_boxes_curr=dpm_curr{3,dpm_cat_no};
        cell_features=cell(2,size(dpm_boxes_curr,1));
        for box_no=1:size(dpm_boxes_curr,1)
            box_curr=dpm_boxes_curr(box_no,:);
            
            box_rs=reshape(box_curr(1:4),2,2);
            boxes_inside=getWindows(box_rs,windowSize);
            im_normal=imread(fullfile(dir_in_pre,name_curr,dir_in_post_feature,normal_mask));
            im_munoz=imread(fullfile(dir_in_pre,name_curr,dir_in_post_feature,munoz_mask));
            
            vec_normal=getVectorsFromWindows( im_normal,boxes_inside,show );
            vec_munoz=getVectorsFromWindows( im_munoz,boxes_inside,show );
            cell_features{1,box_no}=vec_normal;
            cell_features{2,box_no}=vec_munoz;
            
            
            if show>0
                h=figure;
                imshow(imread(fullfile(dir_in_pre,name_curr,dir_in_post,'object_mask_overlay.png')));
                for i=1:numel(boxes_inside)
                    plotBoxes(h,boxes_inside{i},'-b');
                end
%                 keyboard;
            end
        end
        cell_features_all{1,dpm_cat_no}=cell_features(1,:);
        cell_features_all{2,dpm_cat_no}=cell_features(2,:);
        
        
    end
    record(end-1:end,idx_dpm_curr)=cell_features_all;
%     idx_dpm_curr
%     record(:,idx_dpm_curr)
%     keyboard;
end

% save('dpm_greater_-1_bbox_record_withDetections_withFeatureVecs.mat');
save('dpm_greater_-1_bbox_record_withDetections_multiCat_withFeatureVecs.mat')


