function [cp]=crossValidate_LibSVM(features,class_gt,k,C,sigma,weights)

k_idx= crossvalind('Kfold', numel(class_gt),k);

cps=zeros(1,k);
for i=1:k
    test_idx=k_idx==i;
    train_idx=~test_idx;
    f_test=features(test_idx,:);
    class_test=class_gt(test_idx);
    
    f_train=features(train_idx,:);
    class_train=class_gt(train_idx);
    
    cmd = ['-c ', num2str(C), ' -g ', num2str(sigma) ' -w0 ' num2str(weights(1)) ' -w1 ' num2str(weights(2)) ' -q'];
    model= svmtrain(class_train, f_train, cmd);
    [class_pred, accuracy_L, dec_values_L] = svmpredict(class_test, f_test,model,'-q');
    
    one_right=sum(class_pred==1 & class_test==1)/sum(class_test==1);
    zeros_right=sum(class_pred==0 & class_test==0)/sum(class_test==0);
    
    cps(i)=(one_right+zeros_right)/2;
    
end
cp=mean(cps);

end