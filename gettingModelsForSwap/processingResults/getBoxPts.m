function [box_pts]=getBoxPts(temp)
x=temp([1,1,3,3]);
y=temp([2,4,4,2]);
box_pts=[x;y];
end