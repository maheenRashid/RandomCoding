function [h]=visualizeCam(h,eye,ref,up,max_pt)
if nargin<5
    max_pt=100;
end
figure(h);
quad=getQuad(eye);
min_pt=0;
plotWalls(h,min_pt,max_pt,quad);
hold on;
plot3(eye(1),eye(2),eye(3),'om');

plot3(ref(1),ref(2),ref(3),'.k');
plot3([eye(1),ref(1)],[eye(2),ref(2)],[eye(3),ref(3)],'-c','linewidth',3);
up_pt=ref+100*up;

plot3([up_pt(1),ref(1)],[up_pt(2),ref(2)],[up_pt(3),ref(3)],'-c','linewidth',3);

end


