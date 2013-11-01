ccc

cat_mask=imread('raw_cat_mask.png');
group_mask=imread('raw_object_mask.png');
walls=rgb2gray(imread('final_rep_005_000_normal.png'));

figure;
imagesc(cat_mask);
axis off;
figure;imagesc(group_mask);axis off;
figure;

group_ids=unique(group_mask);
group_ids(group_ids==0)=[];

for i=1:numel(group_ids)
bin=group_mask==group_ids(i);
k=walls(bin);
unique(k)
walls_temp=walls;
walls_temp(~bin)=0;
imshow(walls_temp);
pause;
end


