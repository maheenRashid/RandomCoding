function [accuracy]=getAccuracy(pred_vs_real,class)
    
    count_total=0;
    count_right=0;
    count_wrong=0;
    count_class_right=0;
    count_class_wrong=0;
    count_class_total=0;
    accuracy=zeros(1,2);
    
    for i=1:numel(pred_vs_real)
        pvr_curr=pred_vs_real{i};
        gt=pvr_curr(:,1);
        pred=pvr_curr(:,2);
        count_total=count_total+size(pvr_curr,1);
        count_right=count_right+numel(find(gt==pred));
        count_wrong=count_wrong+numel(find(gt~=pred));
        
        gt_class=gt==class;
        count_class_total=count_class_total+numel(find(gt_class));
        count_class_right=count_class_right+numel(find(gt(gt_class)==pred(gt_class)));
        count_class_wrong=count_class_wrong+numel(find(gt(gt_class)~=pred(gt_class)));
        
    end

    accuracy(1)=count_right/count_total;
    accuracy(2)=count_class_right/count_class_total;
    
end