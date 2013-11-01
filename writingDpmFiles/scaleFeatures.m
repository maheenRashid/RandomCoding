function [ scaled_features,range_f ] = scaleFeatures( features,range )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

if nargin<2
    range=[0;1];
end

if size(range,2)==1
    range=repmat(range,1,size(features,2));
end

range_f=zeros(size(range));
scaled_features=zeros(size(features));

for f_no=1:size(features,2)
    f_curr=features(:,f_no);
    range_curr=range(:,f_no);
    
    min_f=min(f_curr);
    max_f=max(f_curr);
    
    range_f(1,f_no)=min_f;
    range_f(2,f_no)=max_f;
    
    %bring the range to 0,1
    f_curr=f_curr-min_f;
    if max(f_curr)~=0
        f_curr=f_curr/max(f_curr);
    end
    
    %now scale to range specified
    f_curr=f_curr*(range_curr(2)-range_curr(1));
    f_curr=f_curr+range_curr(1);
    scaled_features(:,f_no)=f_curr;
   
end


end

