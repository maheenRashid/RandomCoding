ccc
parent_dir='swapObjectsInBox_allOffsets_sizeComparison_bestSortedByDPMScore_auto';
im_dir=fullfile(parent_dir,'b#bedroom#sun_agasopcfwxqzgikd');

im_normal=dir(fullfile(im_dir,'each_rep*normal.png'));
im_normal=imread(fullfile(im_dir,im_normal(1).name));

% im_normal=dir(fullfile(im_dir,'each_rep*normal.png'));
im_normal=imread(fullfile(im_dir,'orig_with_cube_normal.png'));


im_picture=dir(fullfile(im_dir,'each_rep*overlay.png'));
im_picture=imread(fullfile(im_dir,im_picture(1).name));

im_merge=im_normal/2+im_picture;
bw=sum(im_normal,3);
bw=bw==0;
bw=~bw;
bw=uint8(bw);
im_merge=im_merge.*repmat(bw,[1,1,3]);
figure;
imshow(im_merge)

imwrite(im_merge,fullfile(im_dir,'overlay_normal_with_cube.png'));
