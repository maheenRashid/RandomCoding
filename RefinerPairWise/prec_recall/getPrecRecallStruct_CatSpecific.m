function [prec_recall]=getPrecRecallStruct_CatSpecific(prec_recall,record_accuracy,cat_no,gt_cat)

cats=record_accuracy.cats;
cats_bin=cats==cat_no;

dpm_bin=record_accuracy.dpm_bin;
dpm_bin(~cats_bin)=0;

bin_kept_dpm=ones(size(dpm_bin));
bin_kept_dpm(~cats_bin)=0;

total_gt=sum(gt_cat==cat_no);
obj_map=record_accuracy.obj_map;
obj_map(~cats_bin)=0;

[prec_recall.dpm]=getPrecRecall(bin_kept_dpm...
    ,dpm_bin,obj_map,total_gt);

if isempty(record_accuracy.pred)
    bin_kept_nn=record_accuracy.pred;
    bin_kept_nn_best=record_accuracy.pred;
else
    bin_kept_nn=record_accuracy.pred(:,end);
    bin_kept_nn_best=record_accuracy.gt(:,end);
    bin_kept_nn(~cats_bin)=0;
    bin_kept_nn_best(~cats_bin)=0;
end



[prec_recall.nn_dpm]=getPrecRecall(bin_kept_nn,dpm_bin,...
    obj_map,total_gt);
[prec_recall.nn_dpm_best]=getPrecRecall(bin_kept_nn_best,dpm_bin,...
    obj_map,total_gt);

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
