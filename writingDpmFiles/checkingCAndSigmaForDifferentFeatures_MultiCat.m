ccc
load('dpm_greater_-1_bbox_record_withDetections_multiCat_withFeatureVecs_compiled_SVM.mat',...
    'dpm_svm_data','errorLog');
load('gt_list.mat');

load('findingCAndSigmaForDifferentFeatures_MultiCat.mat','record_svm','C_sigma_best');

addpath('E:\RandomCoding\libsvm-3.17\windows');


catsWeConsider=[8,9,10,11,12];
for i=1:size(dpm_svm_data,2)
    lab_curr=dpm_svm_data{2,i};
    if isempty(lab_curr)
        continue
    end
    for lab_no=1:numel(lab_curr)
        if sum(lab_curr(lab_no)==catsWeConsider)==0
            lab_curr(lab_no)=0;
        end
    end
    dpm_svm_data{2,i}=lab_curr;
end
labs=[0,catsWeConsider];




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
        [weights]=getWeights(class_train,labs);
        weightsAndLabs=[weights;labs];
        
        
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
        
        
        w_str='';
        for w_no=1:size(weightsAndLabs,2)
            w_str=[w_str ' -w' num2str(weightsAndLabs(2,w_no)) ' ' num2str(weightsAndLabs(1,w_no))];
        end
        svm_model = svmtrain(class_train, features_train_sparse, ...
            [' -c ', num2str(C), ' -g ',num2str(sigma), w_str,' -q -b 1']);
        
        
        [class_pred, accuracy_L, dec_values_L] = svmpredict(class_test, features_test_sparse,svm_model,'-b 1');
        disp('result on testing')
        bsr=getBSR(class_pred,class_test,labs)
        bsr_previous=record_svm{1,fold_no,f_combo_no}
        bsr_comp(1,fold_no,f_combo_no)=bsr;
        bsr_comp(2,fold_no,f_combo_no)=bsr_previous;
%         pause;
%         clc
    end
end