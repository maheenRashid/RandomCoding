ccc

cam_dir_meta='/lustre/maheenr/cube_per_cam_regenerate/room3D_gt/';
model_name='b#bedroom#sun_aaajwnfblludyasb';
dir_bin_box='swap_in_box';
im_bin_box_name=fullfile(cam_dir_meta,dir_bin_box,model_name,'renderings','cube_bin_all000.png');
im_org_name='im_org.jpg';

im=imread(im_org_name);
im_bin_box=imread(im_bin_box_name);


dir_swaps=fullfile(cam_dir_meta,'test',model_name,'renderings');
fnames=dir(fullfile(dir_swaps,'list*normal.png'));
fnames={fnames(:).name};

im_bin_box=im_bin_box>0;
im_bin_box=uint8(im_bin_box);


for i=1:numel(fnames)
    pre_curr=fnames{i};
    pre_curr=pre_curr(1:end-11);
   
    mask_3d=imread(fullfile(dir_swaps,[pre_curr '_overlay.png']));
   
    im_normal=imread(fullfile(dir_swaps,[pre_curr '_normal.png']));
    mask_3d=getMaskFromOverlay(im,mask_3d);
    normal_rel=im_normal.*mask_3d;
    im_curr=im/2+normal_rel/2;
    im_curr=im_curr.*im_bin_box;
    out_file_name=[pre_curr '_box_overlay.png'];
    imwrite(im_curr,fullfile(dir_swaps,out_file_name));
end
