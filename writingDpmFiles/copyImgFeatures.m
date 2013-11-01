% ccc
% gt_list=getNamesFromDir('D:\3DGP\indoorunderstanding_3dgp-master\maheen_code\gt_models');
% save('gt_list.mat');
% return
load('gt_list.mat');
dir_in_pre='/home/ssatkin/AWS-DATA/data/image_payloads/SUN_Images';
dir_out='gt_models';

if ~exist(dir_out,'dir')
    mkdir(dir_out);
end

for file_no=1:numel(gt_list)
    file_no
    gt_list{file_no}
    str_file=strrep(gt_list{file_no},'#','/');
    str_path=fullfile(dir_in_pre,str_file,'*');
    str_path=strrep(str_path,'\','/');
%     keyboard
    if ~exist(fullfile(dir_out,gt_list{file_no}),'dir')
        mkdir(fullfile(dir_out,gt_list{file_no}));
    end
    copyfile(str_path,fullfile(dir_out,gt_list{file_no}))
end

% /home/ssatkin/AWS-DATA/data/image_payloads/SUN_Images/l/living_room/sun_bzybufberuuzchjl