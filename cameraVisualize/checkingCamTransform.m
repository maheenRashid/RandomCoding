ccc
load('temp_camTransform.mat');
pts
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
pts_t=pts_t(1:end-1,:)
ref_t=H*[ref;1];
ref_t=ref_t/ref_t(end);
ref_t=ref_t(1:3);
% visualize axis before;
mag=100;

orig=eye;
x=orig+mag*u;
y=orig+mag*v;
z=orig+mag*n;
figure;
hold on;
plot3([orig(1),x(1)],[orig(2),x(2)],[orig(3),x(3)],'-r','linewidth',3);
plot3([orig(1),y(1)],[orig(2),y(2)],[orig(3),y(3)],'-g','linewidth',3);
plot3([orig(1),z(1)],[orig(2),z(2)],[orig(3),z(3)],'-b','linewidth',3);
plot3([orig(1),ref(1)],[orig(2),ref(2)],[orig(3),ref(3)],'-c','linewidth',3);
plot3(pts(1,:),pts(2,:),pts(3,:),'-*y','linewidth',5);
hold off;
axis equal;
% visualize axis after;
orig=[0,0,0];
x=mag*[1,0,0]';
y=mag*[0,1,0]';
z=mag*[0,0,1]';
figure;
hold on;
plot3([orig(1),x(1)],[orig(2),x(2)],[orig(3),x(3)],'-r','linewidth',3);
plot3([orig(1),y(1)],[orig(2),y(2)],[orig(3),y(3)],'-g','linewidth',3);
plot3([orig(1),z(1)],[orig(2),z(2)],[orig(3),z(3)],'-b','linewidth',3);
plot3([orig(1),ref_t(1)],[orig(2),ref_t(2)],[orig(3),ref_t(3)],'-c','linewidth',3);
plot3(pts_t(1,:),pts_t(2,:),pts_t(3,:),'-*y','linewidth',5);
hold off;
axis equal;
