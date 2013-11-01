function [cp]=crossValidate_LibSVM_MultiCat(features,class_gt,k,C,sigma,weightsAndLabs)

k_idx= crossvalind('Kfold', numel(class_gt),k);

cps=zeros(1,k);
for i=1:k
    test_idx=k_idx==i;
    train_idx=~test_idx;
    f_test=features(test_idx,:);
    class_test=class_gt(test_idx);
    
    f_train=features(train_idx,:);
    class_train=class_gt(train_idx);
    
    w_str='';
    for w_no=1:size(weightsAndLabs,2)
        w_str=[w_str ' -w' num2str(weightsAndLabs(2,w_no)) ' ' num2str(weightsAndLabs(1,w_no))];
    end
    
    cmd = ['-c ', num2str(C), ' -g ', num2str(sigma),w_str,' -q'];
    model= svmtrain(class_train, f_train, cmd);
    [class_pred, accuracy_L, dec_values_L] = svmpredict(class_test, f_test,model);
    
    cps(i)=getBSR(class_pred,class_test,weightsAndLabs(2,:));
    
end
cp=mean(cps);

end