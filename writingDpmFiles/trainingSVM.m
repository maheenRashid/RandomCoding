% ccc
% load('dpm_greater_-1_bbox_record_withDetections_withFeatureVecs_compiled_SVM.mat');
% load('gt_list.mat');
% 
% svm_struct_cell=cell(1,numel(gt_list));
% features_and_class_combined=cell(2,numel(gt_list));
% for gt_no=1:numel(gt_list)
%     gt_no
%     name_curr=gt_list{gt_no}
%     if numel(find(strcmp(name_curr,errorLog)))>0
%         continue;
%     end
%     fold_idx_curr=gt_fold_idx{gt_no};
%     dpm_svm_curr=dpm_svm_data(:,fold_idx_curr);
%     features_curr=dpm_svm_curr(1,:);
%     features_curr=features_curr';
%     features_curr=cell2mat(features_curr);
%     
%     features_curr=features_curr(:,1:6);
%     
%     %     keyboard
%     class_curr=dpm_svm_curr(2,:);
%     class_curr=class_curr';
%     class_curr=cell2mat(class_curr);
%     [svm_struct_curr]=svmtrain(features_curr,class_curr,'kernel_function','rbf','kktviolationlevel',0.15);
%     svm_struct_cell{gt_no}=svm_struct_curr;
%     features_and_class_combined{1,gt_no}=features_curr;
%     features_and_class_combined{2,gt_no}=class_curr;
%     % return
% end
% 
% 
% save('svm_structs_etc_justBBAndConfAndType.mat','gt_list','errorLog',...
%     'features_and_class_combined','svm_struct_cell');
% 
% 
% 
% 
% 
% 
% 
% 
% return
%%
ccc

load('dpm_greater_-1_bbox_record_withDetections_multiCat_withFeatureVecs.mat','record');
load('gt_list.mat');

dpm_svm_data=cell(2,numel(gt_list));
for gt_no=1:numel(gt_list)
    
    name_curr=gt_list{gt_no}
    if numel(find(strcmp(name_curr,errorLog)))>0
        continue;
    end
    
    name_dpm=regexpi(name_curr,'#','split');
    name_dpm=name_dpm{end};
    dpm_curr=strcmp(name_dpm,record(2,:));
    idx_dpm_curr=find(dpm_curr);
    dpm_curr=record(:,dpm_curr);
    
    [featureVec,class]=getSVMDataFromRecord(dpm_curr);
    dpm_svm_data{1,gt_no}=featureVec;
    dpm_svm_data{2,gt_no}=class;
%     keyboard;
end

save('dpm_greater_-1_bbox_record_withDetections_multiCat_withFeatureVecs_compiled_SVM.mat');
