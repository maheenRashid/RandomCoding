function [ pts_t ] = transformToCameraCoordinates( eye,ref,up,pts )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

n=eye-ref;
u=cross(up,n);
v=cross(n,u);

n=n/norm(n);
u=u/norm(u);
v=v/norm(v);

rotMat=[u';v';n'];
t=[-dot(eye,u),-dot(eye,v),-dot(eye,n)]';

H=[[rotMat,t];[0,0,0,1]];
pts_t=H*[pts;ones(1,size(pts,2))];
pts_t=pts_t./repmat(pts_t(end,:),size(pts_t,1),1);
pts_t=pts_t(1:end-1,:);
end

