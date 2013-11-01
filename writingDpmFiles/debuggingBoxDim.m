ccc
load('dpm_greater_-1_bbox_record_withDetections_withFeatureVecs_compiled_SVM.mat','dpm_svm_data');
load('gt_list.mat');
dir_in_pre='gt_models';
dir_in_post='Img_GT_Features';


for gt_no=1:numel(gt_list)
    gt_no
    name_curr=gt_list{gt_no}
    if numel(find(strcmp(name_curr,errorLog)))>0
        continue;
    end
    
    feature_curr=dpm_svm_data{1,gt_no};
    class_curr=dpm_svm_data{2,gt_no};
    
    bin_problem=0;
    
    problem_boxes=find(feature_curr(:,1)-feature_curr(:,2)>0);
    
    h=figure
         imshow(imread(fullfile(dir_in_pre,name_curr,dir_in_post,'object_mask_overlay.png')));
     
     for box_no=problem_boxes'
         name_curr
         gt_no
         feature_curr(box_no,1:4)
        plotBoxes(h,feature_curr(box_no,1:4),'-r');
        pause;
     end

    



end