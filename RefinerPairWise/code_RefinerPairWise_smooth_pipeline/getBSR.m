function [ bsr,other_accu ] = getBSR( accus )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    vals=unique(accus(:,2));
    other_accu=ones(1,3);
    other_accu(end)=sum(accus(:,1))/numel(accus(:,1));
    bsr=0;
    for val_no=1:numel(vals)
        bin=accus(:,2)==vals(val_no);
        other_accu(vals(val_no)+1)=(sum(accus(bin,1))/sum(bin));
        bsr=bsr+(sum(accus(bin,1))/sum(bin));
    end
    bsr=bsr/numel(vals);
end

