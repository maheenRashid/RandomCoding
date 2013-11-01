ccc
% svm_type='svm_structs_etc_violate.mat';
% svm_type='svm_structs_etc.mat';
svm_type='svm_structs_etc_justBBAndConfAndType.mat';


load(svm_type);
load('dpm_greater_-1_bbox_record_withDetections_withFeatureVecs_compiled_SVM.mat'...
    ,'dpm_svm_data','gt_list','errorLog');

pred_vs_real=cell(1,numel(gt_list));
for gt_no=1:numel(gt_list)
    gt_no
    name_curr=gt_list{gt_no}
    if numel(find(strcmp(name_curr,errorLog)))>0
        continue;
    end
    feature_test=dpm_svm_data{1,gt_no};
    feature_test=feature_test(:,1:6);
    class_gt=dpm_svm_data{2,gt_no};
    
    class_pred = svmclassify(svm_struct_cell{gt_no},feature_test);
    pred_vs_real{1,gt_no}=[class_gt,class_pred];
end

save(svm_type);
