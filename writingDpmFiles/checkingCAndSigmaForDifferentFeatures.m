ccc
load('dpm_greater_-1_bbox_record_withDetections_withFeatureVecs_compiled_SVM.mat',...
    'dpm_svm_data','errorLog');
load('gt_list.mat');

load('findingCAndSigmaForDifferentFeatures.mat','record_svm','C_sigma_best');

addpath('E:\RandomCoding\libsvm-3.17\windows');


k=5;
svm_struct_cell=cell(4,numel(gt_list));
pred_vs_real=cell(1,numel(gt_list));

c_pow_range=[-1:3];
sigma_pow_range=[-4:1];


feature_range_cell={[1:5],[1:10],[1:5,11:85],[1:85],[1:5,86:110],[1:10,86:110],[1:110]};
bsr_comp=zeros(2,5,numel(feature_range_cell));
% record_svm=cell(4,5,numel(feature_range_cell));
for fold_no=1:5
    
    idx_all=find(gt_folds==fold_no);
    test_idx=randperm(numel(idx_all),round(numel(idx_all)/5));
    idx_bin=zeros(size(idx_all));
    idx_bin(test_idx)=1;
    
    idx_train=idx_all(idx_bin==0);
    idx_test=idx_all(idx_bin==1);
    
    dpm_svm_train=dpm_svm_data(:,idx_train);
    features_train_org=dpm_svm_train(1,:);
    features_train_org=features_train_org';
    features_train_org=cell2mat(features_train_org);
    class_train=dpm_svm_train(2,:);
    class_train=class_train';
    class_train=cell2mat(class_train);
    
    features_test_org=dpm_svm_data(1,idx_test);
    features_test_org=cell2mat(features_test_org');
    class_test=dpm_svm_data(2,idx_test);
    class_test=cell2mat(class_test');
    if numel(features_test_org)==0
        continue
    end
    for f_combo_no=1:numel(feature_range_cell)
        weights=[0,0];
        no_pos=sum(class_train==1);
        no_neg=sum(class_train==0);
        
        weights(2)=no_neg/no_pos;
        weights(1)=1;
        
        weights;
        
        features_train=features_train_org(:,feature_range_cell{f_combo_no});
        features_test=features_test_org(:,feature_range_cell{f_combo_no});
        
        
        C=C_sigma_best(1,f_combo_no);
        sigma=C_sigma_best(2,f_combo_no);
        
        
        minimums = min(features_train, [], 1);
        ranges = max(features_train, [], 1) - minimums;
        
        features_train_scale = (features_train - repmat(minimums, size(features_train, 1), 1)) ./ repmat(ranges, size(features_train, 1), 1);
        
        features_test_scale = (features_test - repmat(minimums, size(features_test, 1), 1)) ./ repmat(ranges, size(features_test, 1), 1);
        features_test_scale(isnan(features_test_scale))=0;
        
        features_test_sparse=sparse(features_test_scale);
        features_train_sparse=sparse(features_train_scale);
        
        svm_model = svmtrain(class_train, features_train_sparse, ...
            [' -c ', num2str(C), ' -g ', num2str(sigma) ' -w0 ' num2str(weights(1)) ' -w1 ' num2str(weights(2)) ' -q -b 1 -q']);
        
        
        
        
        [class_pred, accuracy_L, dec_values_L] = svmpredict(class_test, features_test_sparse,svm_model,'-b 1 -q');
        disp('result on testing')
        one_right=sum(class_pred==1 & class_test==1)/sum(class_test==1);
        zeros_right=sum(class_pred==0 & class_test==0)/sum(class_test==0);
        bsr=(one_right+zeros_right)/2
        bsr_previous=record_svm{1,fold_no,f_combo_no}
        bsr_comp(1,fold_no,f_combo_no)=bsr;
        bsr_comp(2,fold_no,f_combo_no)=bsr_previous;
%         pause;
%         clc
    end
end