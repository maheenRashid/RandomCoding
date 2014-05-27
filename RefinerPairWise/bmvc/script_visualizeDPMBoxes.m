ccc
addpath ../code_RefinerPairWise_smooth_pipeline/
addpath ../gettingOrientationInfo/

im_path='D:\3DGP\LabelMe_images\users\satkin\suns_gt_im';
% im_name_full='b#bedroom#sun_aajmgjyzfecnphxv';
im_name_full='b#bedroom#sun_aaajwnfblludyasb';

load('record_dpm.mat');

mapping=[1,2,4,8,9];
color_str={'g','y','b','r','m'};

lWidth=3;

im_name=im_name_full;
if numel(strfind(im_name,'#'))>0
    im_name=regexpi(im_name_full,'#','split');
    im_name=im_name{end};
end
load('record_lists_sun_aaaj.mat');

im=imread(fullfile(im_path,[im_name '.jpg']));
% im_bin=imread('bin_box.png');
% G = fspecial('gaussian',[3,3],1);
% im_bin=imfilter(im_bin,G,'same');
%  im_bin = edge(im_bin(:,:,1));
% im_bin=im_bin<1;
% im_bin=uint8(cat(3,cat(3,im_bin,im_bin),im_bin));
% im_check=im.*im_bin;
% imshow(im_check);
% return
% im_2=imread('overlay_obj.png');
% mask_3d=getMaskFromOverlay(im,im_2);
% 
normal=imread('walls.png');
% normal_rel=normal.*mask_3d;
im_check=2*im/3+normal/3;
% _rel/2;

% figure; imshow(im_new);
% figure; imagesc(im_2);
% return



ids_dpm={record_dpm(:).id};

idx=find(strcmp(im_name,ids_dpm));
rec_dpm=record_dpm(idx);
cats=rec_dpm.cat_no;
boxes=rec_dpm.boxes;
boxes=boxes(:,1:4);

% cats=cats(rec_dpm.bin>0);
% boxes=boxes(rec_dpm.bin>0,:);
% 
% cats=cats(10);
% boxes=boxes(10,:);



pts=cell(size(boxes,1),1);
colors=cell(size(pts));
for i=1:numel(cats)
    bPts=getBoxPts(boxes(i,:));
    pts{i}=[bPts,bPts(:,1)];
    colors{i}=color_str{mapping==cats(i)};
end



figure;
imshow(im_check);
hold on;
for i=1:numel(pts)
    bPts=pts{i};
    plot(bPts(1,:),bPts(2,:),['-' colors{i}],'linewidth',lWidth);
end
hold off;


