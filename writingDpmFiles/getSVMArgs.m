function [ C,sigma,cross_val_rec ] = getSVMArgs( features_curr,class_curr,k,c_pow_range,sigma_pow_range )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
if nargin<4
    c_pow_range=-5:2:15;
end
if nargin<5
    sigma_pow_range=-15:2:3;
end

[f_scale]=scaleFeatures(features_curr);


cross_val_rec=cell(numel(c_pow_range),numel(sigma_pow_range));

for c_pow=c_pow_range
    for sigma_pow=sigma_pow_range
        C=2^c_pow
        sigma=2^sigma_pow
        
        error=crossValidate(f_scale,class_curr,k,C,sigma);
        cross_val_rec{c_pow==c_pow_range,sigma_pow==sigma_pow_range}=error;
    end
end

spec_all=zeros(size(cross_val_rec));
for i=1:size(cross_val_rec,1)
    for j=1:size(cross_val_rec,2)
        %         spec_all(i,j)=cross_val_rec{i,j}.Sensitivity;
        spec_all(i,j)=cross_val_rec{i,j}.Specificity;
    end
end

[max_val,max_idx]=min(spec_all(:));
[x,y]=ind2sub(size(cross_val_rec),max_idx);
C=2^c_pow_range(x);
sigma=2^sigma_pow_range(y);


end

