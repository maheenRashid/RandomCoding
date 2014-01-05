ccc

dir_im='b#bedroom#sun_aaajwnfblludyasb/renderings';

files=dir(fullfile(dir_im,'list_*.png'));

im_org_name='each_rep_-01_-01_-01_-01_-01_overlay.png';

names={files(:).name};
names_pre=cellfun(@(x) strfind(x,'_'),names,'UniformOutput',0);
names_pre=cellfun(@(x,y) x(1:y(end)-1),names,names_pre,'UniformOutput',0);

names_pre=unique(names_pre);

out_dir=fullfile('aaj_new_renderings');
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end


for im_no=1:numel(names_pre)

    %get overlay
    im_overlay=imread(fullfile(dir_im,[names_pre{im_no} '_overlay.png']));
    
    %get normal 
    im_normal=imread(fullfile(dir_im,[names_pre{im_no} '_normal.png']));
    
    %get org im
    im_org=imread(fullfile(dir_im,im_org_name));
    
    im_mask=im_overlay-im_org;
    im_mask=rgb2gray(im_mask);
    im_mask=uint8(im_mask>0);
    
    im_normal_mask=im_normal.*repmat(im_mask,[1,1,3]);
    
    im_overlay_normal=im_org+0.5*im_normal_mask;
    
    imwrite(im_overlay_normal,fullfile(out_dir,[names_pre{im_no} '_merge.png']));
    
end


