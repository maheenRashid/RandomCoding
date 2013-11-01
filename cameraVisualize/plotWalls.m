function [ h ] = plotWalls(h,min_pt,max_pt,quad)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
maxX=max_pt;
maxY=max_pt;
maxZ=max_pt;

if (quad == 2 || quad == 3)
    maxX = -maxX;
end
if (quad == 3 || quad == 4)
    maxY = -maxY;
end

figure(h);
hold on;
fill3([min_pt,min_pt,min_pt,min_pt],[min_pt,maxY,maxY,min_pt],[min_pt,min_pt,maxZ,maxZ],'g');

fill3([min_pt,min_pt,maxX,maxX],[min_pt,maxY,maxY,min_pt],[min_pt,min_pt,min_pt,min_pt],'b');

fill3([min_pt,maxX,maxX,min_pt],[min_pt,min_pt,min_pt,min_pt],[min_pt,min_pt,maxZ,maxZ],'r');
end

