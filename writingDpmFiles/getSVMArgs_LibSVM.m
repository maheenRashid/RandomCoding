function [ bestc,bestg,bestcv,cvs ] = getSVMArgs_LibSVM( features_curr,class_curr,k,c_pow_range,sigma_pow_range,weights )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

if nargin<4
    c_pow_range=-5:2:15;
end
if nargin<5
    sigma_pow_range=-15:2:3;
end
if nargin<6
    weights=[1,20];
end


bestcv=0;
bestc=0;
bestg=0;
cvs = zeros(numel(c_pow_range),numel(sigma_pow_range));
for log2c = c_pow_range,
    for log2g = sigma_pow_range,
        c_curr=2^log2c;
        g_curr=2^log2g;
        
%         fprintf('c_no=%g, sigma_no=%g\n',find(log2c==c_pow_range),find(log2g==sigma_pow_range));
%         fprintf('c_curr=%g, sigma_no=%g\n',find(log2c==c_pow_range),find(log2g==sigma_pow_range));
        cv=crossValidate_LibSVM(features_curr,class_curr,k,c_curr,g_curr,weights);
        cvs(log2c==c_pow_range,log2g==sigma_pow_range)=cv;
        if (cv >= bestcv),
            bestcv = cv; bestc = 2^log2c; bestg = 2^log2g;
        end
        
%         fprintf('%g %g %g (best c=%g, g=%g, rate=%g)\n', log2c, log2g, cv, bestc, bestg, bestcv);
    end
end


end

