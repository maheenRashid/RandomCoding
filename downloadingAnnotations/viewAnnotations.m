ccc

addpath(genpath('D:\3DGP\LabelMeToolbox'));

% anno_data=LMdatabase('gt_models_anno');
% save('anno_data.mat');

% anno_data_scott=LMdatabase('D:\3DGP\LabelMe_annotations\users\satkin\suns_gt_im');
% save('anno_data_scott.mat');
% return
% load('anno_data_scott.mat');

load('anno_data.mat');
im_dir='gt_models_im';
% im_dir='http://labelme.csail.mit.edu/Images/users/antonio/static_sun_database';
[anno_cush, j] = LMquery(anno_data, 'object.name', 'side','word');

[names,counts]=LMobjectnames(anno_cush);


for i=1:numel(anno_cush)
    im_str=fullfile(im_dir,['l#living_room#' anno_cush(i).annotation.filename]);
    if ~exist(im_str,'file')
        im_str=fullfile(im_dir,['b#bedroom#' anno_cush(i).annotation.filename]);
    end
%     im_str=fullfile(im_dir,anno_cush(i).annotation.filename);
%     return
    displayObjects(anno_cush(i),im_str);
    pause;
end

% 
% [names,counts]=LMobjectnames(anno_data);
% 
% [matches,idx]=matchString(names,'futon');
% matches
% counts(idx)
