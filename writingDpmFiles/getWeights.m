function [weights]=getWeights(class_train,labels)
    count_vec=zeros(1,numel(labels));
    
    for i=1:numel(count_vec)
        count_vec(i)=sum(labels(i)==class_train);
    end
    
    count_neg=count_vec(labels==0);
    if count_neg==0
        keyboard;
    end
    weights=repmat(count_neg,size(count_vec))./count_vec;
%     keyboard;

    
end