function [prec_recall]=getPrecRecall(bin_kept,accu,obj_map,total_gt)

    prec_recall=zeros(2,2);
    prec_recall(4)=total_gt;
    if isempty(bin_kept)
        return;
    end
    bin_kept=bin_kept>0;
    accu=accu(bin_kept,:);
    prec_recall(1)=sum(accu(:,1));
    prec_recall(2)=numel(accu(:,1));
    
    obj_map=obj_map(bin_kept);
    uni=unique(obj_map);
    uni(uni==0)=[];
    prec_recall(3)=numel(uni);
    
end