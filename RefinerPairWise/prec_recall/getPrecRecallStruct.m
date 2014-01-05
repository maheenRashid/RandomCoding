function [prec_recall]=getPrecRecallStruct(prec_recall,record_accuracy)
dpm_bin=record_accuracy.dpm_bin;

[prec_recall.dpm]=getPrecRecall(ones(size(dpm_bin))...
    ,dpm_bin,record_accuracy.obj_map,record_accuracy.total_gt);

if isempty(record_accuracy.pred)
    bin_kept_nn=record_accuracy.pred;
    bin_kept_nn_best=record_accuracy.pred;
else
    bin_kept_nn=record_accuracy.pred(:,end);
    bin_kept_nn_best=record_accuracy.gt(:,end);
end
[prec_recall.nn_dpm]=getPrecRecall(bin_kept_nn,dpm_bin,...
    record_accuracy.obj_map,record_accuracy.total_gt);
[prec_recall.nn_dpm_best]=getPrecRecall(bin_kept_nn_best,dpm_bin,...
    record_accuracy.obj_map,record_accuracy.total_gt);

end

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
