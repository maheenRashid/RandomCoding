ccc

dir_cam='E:\gt_cam';
cams_dir=dir(fullfile(dir_cam,'*.txt'));
cams=struct();
for cam_no=1:numel(cams_dir)
fid=fopen(fullfile(dir_cam,cams_dir(cam_no).name));
cam_curr=textscan(fid,'%s','delimiter','\n');
cam_curr=cam_curr{1};
cam_curr=cellfun(@str2num,cam_curr);
cams(cam_no).name=cams_dir(cam_no).name(1:end-4);
cams(cam_no).fov_vertical=cam_curr(2);
cam_curr=cam_curr(3:end);
cams(cam_no).eye=cam_curr(1:3);
cams(cam_no).ref=cam_curr(4:6);
cams(cam_no).up=cam_curr(7:9);
cams(cam_no).width=cam_curr(10);
cams(cam_no).height=cam_curr(11);
fclose(fid);

end

save(fullfile(dir_cam,'all_cams.mat'),'cams');
