ccc

% svm_type='svm_dpm_munoz_norm';
load('dpm_greater_-1_bbox_record_withDetections_withFeatureVecs_compiled_SVM.mat',...
    'dpm_svm_data','errorLog');
load('gt_list.mat');

addpath('E:\RandomCoding\libsvm-3.17\windows');

% if ~exist(svm_type,'dir')
%     mkdir(svm_type);
% end

k=2;
svm_struct_cell=cell(4,numel(gt_list));
pred_vs_real=cell(1,numel(gt_list));

% c_pow_range=[13:0.5:15];
% sigma_pow_range=[-10:0.5:-8];


% c_pow_range=[-5:2:15];
% sigma_pow_range=[-15:2:3];
c_pow_range=[-1:3];
sigma_pow_range=[-4:1];
weights=[1,20];


% C=32768;
% sigma=0.0014;
for gt_no=1:numel(gt_list)
    gt_no
    name_curr=gt_list{gt_no};
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
    
    
    features_train=features_train(:,1:10);
    features_test=features_test(:,1:10);
    
    tic()
    [C,sigma,cp_best,cp_all]=getSVMArgs_LibSVM(features_train,class_train,k,c_pow_range,sigma_pow_range,weights);
    toc()
    [features_train_s,range_train_scale]=scaleFeatures(features_train);
    features_train_sparse=sparse(features_train);
    
    
    
    [features_test_scale,~]=scaleFeatures(features_test,range_train_scale);
    features_test_sparse=sparse(features_test_scale);
    
    svm_model = svmtrain(class_train, features_train, ...
        [' -c ', num2str(C), ' -g ', num2str(sigma) ' -w0 ' num2str(weights(1)) ' -w1 ' num2str(weights(2)) ' -q']);
    
%     svm_model = svmtrain(class_train, features_train, ...
%         [' -c ', num2str(C), ' -w0 1 -w1 100' ' -q ']);
    
    [class_pred, accuracy_L, dec_values_L] = svmpredict(class_test, features_test_sparse,svm_model);
    
    numel(find(class_pred==1 & class_test==1))/numel(find(class_test==1))
    keyboard;
    %     [features_train_s,range_train_scale]=scaleFeatures(features_train);
    %     svm_struct=svmtrain(features_train_s,class_train,'kernel_function','rbf',...
    %         'boxconstraint',C,'rbf_sigma',sigma);
    %
    %     [features_test_s,range_test_scale]=scaleFeatures(features_test,range_train_scale);
    %
    %     class_pred = svmclassify(svm_struct,features_test_s);
    %
    %     pred_vs_real{1,gt_no}=[class_test,class_pred];
    %     svm_struct_cell{1,gt_no}=svm_struct;
    %     svm_struct_cell{2,gt_no}=C;
    %     svm_struct_cell{3,gt_no}=sigma;
    %     svm_struct_cell{4,gt_no}=cp_all;
    %
    %     save(fullfile(svm_type,[svm_type '.mat']));
end
% save(fullfile(svm_type,[svm_type '.mat']));
