function [ bestc,bestg,bestcv,cvs ] = getSVMArgs_LibSVM_MultiCat( features_curr,class_curr,k,c_pow_range,sigma_pow_range,weights )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

bestcv=0;
bestc=0;
bestg=0;
cvs = zeros(numel(c_pow_range),numel(sigma_pow_range));
for log2c = c_pow_range,
    for log2g = sigma_pow_range,
        c_curr=2^log2c;
        g_curr=2^log2g;
        cv=crossValidate_LibSVM_MultiCat(features_curr,class_curr,k,c_curr,g_curr,weights);
        cvs(log2c==c_pow_range,log2g==sigma_pow_range)=cv;
        if (cv >= bestcv),
            bestcv = cv; bestc = 2^log2c; bestg = 2^log2g;
        end
   end
end


end

