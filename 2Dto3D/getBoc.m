
ccc
% im=imread('sun_aaajwnfblludyasb.jpg');
% imshow(im);
% [x,y]=ginput(1);
% x_len=150;
% y_len=150;
% hold on;
% pts=[x,x+x_len,x+x_len,x;y,y,y+y_len,y+y_len];
% pts=[pts,pts(:,1)];
% for i=1:4
%     plot(pts(1,i:i+1),pts(2,i:i+1),'-b');
% end
load('temp_box.mat');
figure;
imshow(im);
hold on;
for i=1:4
    plot(pts(1,i:i+1),pts(2,i:i+1),'-b');
end

% fid=fopen('temp_box.txt','w');
% for i=1:4
%     for j=1:2
%         fprintf(fid,'%s\n',num2str(pts(j,i)));
%     end
% end
% fclose(fid);