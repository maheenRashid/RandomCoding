ccc


cam_dir_meta='/lustre/maheenr/cube_per_cam_regenerate';
gt_dir='room3D_gt';
n=3;
txt_dir=fullfile(cam_dir_meta,gt_dir,['list_files_noNeg_' num2str(n)]);

txt_files=dir(fullfile(txt_dir,'*.txt'));
txt_files={txt_files(:).name};

bin_incomplete=zeros(size(txt_files));

for file_no=1:numel(txt_files)
    fprintf('%d of %d\n',file_no,numel(txt_files));
    fid=fopen(fullfile(txt_dir,txt_files{file_no}));
    data=textscan(fid,'%s','delimiter','\n');
    fclose(fid);
    data=data{1};
    isC=strcmp('C',data);
    sumC=sum(isC);
    tot=str2double(data{1});
    diff=sumC-tot;
    
    if diff~=1
        bin_incomplete(file_no)=1;
    end
   
end