function [cp]=crossValidate(features,class_gt,k,C,sigma)
% 
% cp = classperf(species);
% for i = 1:10
%     test = (indices == i); train = ~test;
%     class = classify(meas(test,:),meas(train,:),species(train,:));
%     classperf(cp,class,test)
% end
% cp.ErrorRate

k_idx= crossvalind('Kfold', numel(class_gt),k);

cp=classperf(class_gt,'Positive', 1, 'Negative', 0);
for i=1:k
%     i
    test_idx=k_idx==i;
    train_idx=~test_idx;
    f_test=features(test_idx,:);
    class_test=class_gt(test_idx);
    
    f_train=features(train_idx,:);
    class_train=class_gt(train_idx);
    
    svm_struct=svmtrain(f_train,class_train,'kernel_function','rbf',...
        'boxconstraint',C,'rbf_sigma',sigma);
    
    class_pred=svmclassify(svm_struct,f_test);
    classperf(cp,class_pred,test_idx);
end
% average_error=cp.ErrorRate;

end