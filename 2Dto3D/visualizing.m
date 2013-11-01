ccc

load('temp.mat','plane_pts','line_pts');
plane_pts=abs(plane_pts);
plane_pts(plane_pts~=0)=1;
 x=[plane_pts(:,end),[0;1;0],plane_pts(:,2),plane_pts(:,1)];
% plane_pts=fliplr(plane_pts);
% plane_pts=[plane_pts,[0;-300;0]]
line_pts(:,2)=[619.738 468.084 -208.157]';
line_pts=[-1 -1 ;-1 -1 ;1 1 ].*line_pts;
line_pts
figure;
hold on
surface(reshape(x(1,:),2,2),reshape(x(2,:),2,2),reshape(x(3,:),2,2));
plot3(line_pts(1,:),line_pts(2,:),line_pts(3,:),'-r')
plot3(line_pts(1,1),line_pts(2,1),line_pts(3,1),'ok')

% ,[1,0,0]);
