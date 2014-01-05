function [pr]=getPrecRecallCompiled(prec_recall)
fields=fieldnames(prec_recall);
fields=fields(2:end);
pr=zeros(2,numel(fields));
for field_no=1:numel(fields)
    pr_curr=cell2mat(eval(['{prec_recall(:).' fields{field_no} '}']));
    for pr_no=1:2
        pr(pr_no,field_no)=getRatioCorrect(pr_curr,pr_no);
    end
end

end

function [temp]=getRatioCorrect(pr_curr,pr_no)
    temp=pr_curr(:,pr_no:2:end);
        temp=sum(temp,2);
        temp=temp(1)/temp(2);
end