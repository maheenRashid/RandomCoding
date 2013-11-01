
ccc
% im=imread('sun_aaajwnfblludyasb.jpg');
% imshow(im);
% hold on;
% [x_all,y_all]=ginput(4)
% pts_all=cell(1,2);
% for pt_no=[1,3]
%     x=x_all(pt_no);
%     y=y_all(pt_no);
%     x_max=x_all(pt_no+1);
%     y_max=y_all(pt_no+1);
% %     x_len=150;
% % y_len=150;
% pts=[x,x_max,x_max,x;y,y,y_max,y_max];
% pts=[pts,pts(:,1)];
% for i=1:4
%     plot(pts(1,i:i+1),pts(2,i:i+1),'-b');
% end
% pts_all{(pt_no+1)/2}=pts;
% end
% type=[1,7];
% save('temp_boxes_2.mat');
load('temp_boxes_2.mat');

figure;
imshow(im);
hold on;
for pt_no=1:numel(pts_all)
    pts=pts_all{pt_no};
for i=1:4
    plot(pts(1,i:i+1),pts(2,i:i+1),'-b');
end
end


fid=fopen('sun_aaajwnfblludyasb.txt','w');
        fprintf(fid,'%s\n',num2str(numel(type)));

for pt_no=1:numel(pts_all)
    pts=pts_all{pt_no}
        fprintf(fid,'%s\n',num2str(type(pt_no)));
for i=1:4
    for j=1:2
        fprintf(fid,'%s\n',num2str(pts(j,i)));
    end
end
        fprintf(fid,'%s\n','C');

end
fclose(fid);