function [quad] = getQuad( eye )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
posX=eye(1)>0;
posY=eye(2)>0;
if (posX && posY)
    quad = 1;
elseif (~posX && posY)
    quad = 2;
elseif (~posX && ~posY)
    quad = 3;
else
    quad = 4;
end
end

