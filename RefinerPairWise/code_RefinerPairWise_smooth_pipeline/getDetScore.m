function score=getDetScore(accus,ratio)

vals=unique(accus(:,2));

bsrs=zeros(numel(vals),1);
weights=zeros(numel(vals),1);
for val_no=1:numel(vals)
    bin=accus(:,2)==vals(val_no);
    bsrs(val_no)=sum(accus(bin,1))/sum(bin);
    weights(val_no)=ratio(vals(val_no)+1)/sum(ratio);
end

score=weights'*bsrs;
end