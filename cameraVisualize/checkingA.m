% ccc
pathA='D:\ResearchCMU\lustre\jasonli1\code\MATLAB\maheen_dataForGTModels\cellA_correctFormat';
file_no=1;
dirA=dir(pathA);
dirA=dirA(3:end);
% load(fullfile(pathA,dirA(file_no).name));
h=figure;
% for compNo=1:numel(A)-1
%     display3DComp(h,A{compNo});
% end

load('D:\ResearchCMU\lustre\jasonli1\code\MATLAB\maheen_dataForGTModels\mergedCompAll\1\sun_aaajwnfblludyasb_1.mat')
display3DComp(h,mergedA);


dir_cam='E:\gt_cam';
cam_name=['b#bedroom#' dirA(file_no).name(1:end-4) '.txt'];
fid=fopen(fullfile(dir_cam,cam_name));
cam_curr=textscan(fid,'%s','delimiter','\n');
cam_curr=cam_curr{1};
cam_curr=cellfun(@str2num,cam_curr);
cam_curr=cam_curr(3:end);
eye=cam_curr(1:3);
ref=cam_curr(4:6);
up=cam_curr(7:9);

quad=getQuad(eye)
min_pt=0;
max_pt=100;
figure(h);
plotWalls(h,min_pt,max_pt,quad);
hold on;
plot3(eye(1),eye(2),eye(3),'om');

plot3([eye(1),ref(1)],[eye(2),ref(2)],[eye(3),ref(3)],'-k');
up_pt=ref+100*up;

plot3([up_pt(1),ref(1)],[up_pt(2),ref(2)],[up_pt(3),ref(3)],'-c','linewidth',5);

axis equal;