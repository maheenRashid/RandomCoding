ccc

svm_type='svm_dpm_munoz_norm';
load('dpm_greater_-1_bbox_record_withDetections_withFeatureVecs_compiled_SVM.mat',...
    'dpm_svm_data','errorLog');
load('gt_list.mat');


if ~exist(svm_type,'dir')
    mkdir(svm_type);
end

k=5;
svm_struct_cell=cell(4,numel(gt_list));
pred_vs_real=cell(1,numel(gt_list));


load(fullfile(svm_type,[svm_type '.mat']));

for gt_no=10:numel(gt_list)
    gt_no
    name_curr=gt_list{gt_no}
    if numel(find(strcmp(name_curr,errorLog)))>0
        continue;
    end
    
    fold_idx_train=gt_fold_idx{gt_no};
    dpm_svm_train=dpm_svm_data(:,fold_idx_train);
    features_train=dpm_svm_train(1,:);
    features_train=features_train';
    features_train=cell2mat(features_train);
    class_train=dpm_svm_train(2,:);
    class_train=class_train';
    class_train=cell2mat(class_train);
    
    features_test=dpm_svm_data{1,gt_no};
    class_test=dpm_svm_data{2,gt_no};
    if numel(features_test)==0
        continue
    end
    
    
    [C,sigma,cp_all]=getSVMArgs(features_train,class_train,k);
    
    [features_train_s,range_train_scale]=scaleFeatures(features_train);
    svm_struct=svmtrain(features_train_s,class_train,'kernel_function','rbf',...
        'boxconstraint',C,'rbf_sigma',sigma);
    
    [features_test_s,range_test_scale]=scaleFeatures(features_test,range_train_scale);
    
    class_pred = svmclassify(svm_struct,features_test_s);
    
    pred_vs_real{1,gt_no}=[class_test,class_pred];
    svm_struct_cell{1,gt_no}=svm_struct;
    svm_struct_cell{2,gt_no}=C;
    svm_struct_cell{3,gt_no}=sigma;
    svm_struct_cell{4,gt_no}=cp_all;
    
    save(fullfile(svm_type,[svm_type '.mat']));
end
save(fullfile(svm_type,[svm_type '.mat']));
