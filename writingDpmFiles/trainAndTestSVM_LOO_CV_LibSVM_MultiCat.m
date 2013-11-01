ccc

load('dpm_greater_-1_bbox_record_withDetections_multiCat_withFeatureVecs_compiled_SVM.mat',...
    'dpm_svm_data','errorLog');
load('gt_list.mat');

load('findingCAndSigmaForDifferentFeatures_MultiCat.mat','feature_range_cell','C_sigma_best');
% feature_range_cell={[1:5],[1:10],[1:5,11:85],[1:85],[1:5,86:110],[1:10,86:110],[1:110]};

svm_type_str={'libsvm_dpm_multiCat','libsvm_dpm_cat_multiCat','libsvm_dpm_norm_multiCat','libsvm_dpm_cat_norm_multiCat',...
    'libsvm_dpm_munoz_multiCat','libsvm_dpm_cat_munoz_multiCat','libsvm_dpm_cat_norm_munoz_multiCat'};



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


for f_combo_no=1:numel(feature_range_cell)
    C=C_sigma_best(1,f_combo_no);
    sigma=C_sigma_best(2,f_combo_no);
    svm_type=svm_type_str{f_combo_no};

    if ~exist(svm_type,'dir')
        mkdir(svm_type);
    end
    
    svm_struct_cell=cell(3,numel(gt_list));
    pred_vs_real=cell(3,numel(gt_list));
    
    for gt_no=1:numel(gt_list)
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
        
        
        [weights]=getWeights(class_train,labs);
        weightsAndLabs=[weights;labs];
        
        features_train=features_train(:,feature_range_cell{f_combo_no});
        features_test=features_test(:,feature_range_cell{f_combo_no});
        
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
        
%         [class_pred, accuracy_L, dec_values_L] = svmpredict(class_test, features_test_sparse,svm_model,'-b 1 -q');
%         
%         one_right=sum(class_pred==1 & class_test==1)/sum(class_test==1);
%         if isnan(one_right)
%             one_right=0;
%         end
%         zeros_right=sum(class_pred==0 & class_test==0)/sum(class_test==0);
%         if isnan(zeros_right)
%             zeros_right=0;
%         end
%         bsr=(one_right+zeros_right)/2;
        fprintf('bsr= %f\n',bsr)
        
        pred_vs_real{1,gt_no}=[class_test,class_pred];
        pred_vs_real{2,gt_no}=bsr;
        pred_vs_real{3,gt_no}=dec_values_L;
        
        svm_struct_cell{1,gt_no}=svm_model;
        svm_struct_cell{2,gt_no}=C;
        svm_struct_cell{3,gt_no}=sigma;
        
        save(fullfile(svm_type,[svm_type '.mat']));
        
%         keyboard;
    end
    save(fullfile(svm_type,[svm_type '.mat']));
end
