ccc

addpath(genpath('D:\3DGP\LabelMeToolbox'));
webpageanno='http://labelme.csail.mit.edu/Annotations/users/antonio/static_sun_database';
webpageim='http://labelme.csail.mit.edu/Images/users/antonio/static_sun_database';
im_list=getNamesFromDir('E:\RandomCoding\writingDpmFiles\gt_models');
out_dir='gt_models_anno';
out_dir_im='gt_models_im';
errorLog=cell(1,0);

if (~exist(out_dir))
    mkdir(out_dir);
end

if (~exist(out_dir_im))
    mkdir(out_dir_im);
end
for im_no=1:numel(im_list);
    im_rep=strrep(im_list{im_no},'#','/');
    [f,status]=urlwrite([webpageim '/' im_rep '.jpg'],fullfile(out_dir_im,[im_list{im_no} '.jpg']));

%     [f,status]=urlwrite([webpageanno '/' im_rep '.xml'],fullfile(out_dir,[im_list{im_no} '.xml']));
%     if status==0
%         errorLog=[errorLog im_list{im_no}];
%     end
end