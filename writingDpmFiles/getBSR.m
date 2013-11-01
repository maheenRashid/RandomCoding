function [bsr,temp]=getBSR(class_pred,class_test,labs)

    perLabAccu=zeros(size(labs));
    for i=1:numel(perLabAccu)
        perLabAccu(i)=(sum(class_pred==labs(i) & class_test==labs(i)))/(sum(class_test==labs(i)));
    end
    temp=perLabAccu;
    perLabAccu(isnan(perLabAccu))=[];
    bsr=sum(perLabAccu)/numel(perLabAccu);
%     keyboard;
    
    
end