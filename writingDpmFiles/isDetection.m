function [ bin ] = isDetection( box_dpm,box_gt,show,h )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

if nargin<3
    show=0;
end

poly_dpm=getBoxPts(box_dpm);
poly_gt=getBoxPts(box_gt);

[poly_union_x,poly_union_y]=polybool('or',poly_dpm(1,:),poly_dpm(2,:),poly_gt(1,:),poly_gt(2,:));
area_union=polyarea(poly_union_x,poly_union_y);

[poly_int_x,poly_int_y]=polybool('and',poly_dpm(1,:),poly_dpm(2,:),poly_gt(1,:),poly_gt(2,:));
area_int=polyarea(poly_int_x,poly_int_y);

bin=area_int/area_union;
if isnan(bin)
    bin=0;
end
% bin=bin>0.5;
% keyboard;
if show>0
    figure(h);
    hold on;
    plot(poly_dpm(1,:),poly_dpm(2,:),'-r','linewidth',3);
    plot(poly_gt(1,:),poly_gt(2,:),'-b','linewidth',3);
    
    try    
    plot(poly_union_x(1,:),poly_union_y(1,:),'-c','linewidth',1);
    plot(poly_int_x(1,:),poly_int_y(1,:),'-y','linewidth',1);
    catch error
        
    end
    title([num2str(area_int) '/' num2str(area_union) '=' num2str(bin) ',' num2str(bin>0.5)]);
end

bin=bin>0.5;
% if isnan(bin)
%     bin=0;
% end
end

