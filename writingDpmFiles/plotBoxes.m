function [ h ] = plotBoxes( h,temp,str)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if nargin<4
    lwidth=2;
end
if nargin<3
    str='-r';
end


if isequal(size(temp),[2,2])
    temp=temp(:);
    temp=temp';
end

figure(h);
hold on;
    plot(temp([1,1,3,3,1]),temp([2,4,4,2,2]),str,'linewidth',lwidth);
hold off;
end

