% load('crossVal_temp.mat');
%
% sen_all=zeros(size(cross_val_rec));
% for i=1:size(cross_val_rec,1)
%     for j=1:size(cross_val_rec,2)
% %         sen_all(i,j)=cross_val_rec{i,j}.Sensitivity;
%         sen_all(i,j)=cross_val_rec{i,j}.Specificity;
%     end
% end
%
% [max_val,max_idx]=min(sen_all(:));
% [x,y]=ind2sub(size(cross_val_rec),max_idx);
% cross_val_rec{x,y}
%
% svm_struct=svmtrain(f_train,class_train,'kernel_function','rbf',...
%         'boxconstraint',C,'rbf_sigma',sigma);
%
% return
% ccc

% load('dpm_greater_-1_bbox_record_withDetections_withFeatureVecs_compiled_SVM.mat','dpm_svm_data');
% load('gt_list.mat');
% 
% 
% fold_idx_curr=gt_fold_idx{gt_no};
% dpm_svm_curr=dpm_svm_data(:,fold_idx_curr);
% features_curr=dpm_svm_curr(1,:);
% features_curr=features_curr';
% features_curr=cell2mat(features_curr);
% class_curr=dpm_svm_curr(2,:);
% class_curr=class_curr';
% class_curr=cell2mat(class_curr);
% 
% %     features_curr=features_curr(1:5,1);
% [C,sigma,cp]=getSVMArgs(features_curr,class_curr,5);
% [features_train_s,range_train_scale]=scaleFeatures(features_curr);
load('cv_temp.mat');
svm_struct=svmtrain(features_train_s,class_curr,'kernel_function','rbf',...
    'boxconstraint',C,'rbf_sigma',sigma);

features_test=dpm_svm_data{1,gt_no};
class_test=dpm_svm_data{2,gt_no};
[features_test_s,range_test_scale]=scaleFeatures(features_test,range_train_scale);

class_pred = svmclassify(svm_struct,features_test_s);

pred_vs_real=[class_test,class_pred]

return
[f_scale,range_scale]=scaleFeatures(features_curr);

c_pow_range=-5:2:15;
sigma_pow_range=-15:2:3;
cross_val_rec=cell(numel(c_pow_range),numel(sigma_pow_range));

for c_pow=c_pow_range
    for sigma_pow=sigma_pow_range
        C=2^c_pow
        sigma=2^sigma_pow
        k=5;
        
        error=crossValidate(f_scale,class_curr,k,C,sigma)
        cross_val_rec{c_pow==c_pow_range,sigma_pow==sigma_pow_range}=error;
    end
end
[f_scale_test,range_scale_test]=scaleFeatures(f_scale,range_scale);

%     isequal(features_curr,f_scale_test)
