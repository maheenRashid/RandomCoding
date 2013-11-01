ccc
im_web_dir='gt_models_im';
anno_web_dir='gt_models_anno';
% load('anno_data.mat');
load('anno_data_scott.mat');
anno_data=anno_data_scott;

im_list=cell(1,numel(anno_data));
for i=1:numel(anno_data)
    name_basic=['l#living_room#' anno_data(i).annotation.filename];
    im_str=fullfile(im_web_dir,name_basic);
    if ~exist(im_str,'file')
        name_basic=['b#bedroom#' anno_data(i).annotation.filename];
    end
    im_list{i}=name_basic;
end

show=0;
im_dpm_dir='E:\RandomCoding\writingDpmFiles\gt_models';


record_labelMe=cell(2,numel(im_list));

for i=1:numel(im_list)
    just_name=regexpi(im_list{i},'[\.]','split');
    just_name=just_name{1}
    
    im_web=imread(fullfile(im_web_dir,[im_list{i}(1:end-4) '.jpg']));
    im_dpm=imread(fullfile(im_dpm_dir,just_name,'resized_image.jpg'));
    data_curr=anno_data(i);
    
    
    
    [objects_resize]=objectsResize(data_curr, size(im_dpm));
    
        
    
    if show>0 && numel(objects_resize)~=1
        im_web_resize=imresize(im_web,[size(im_dpm,1),size(im_dpm,2)]);
        h=figure;
        imshow(im_web_resize);
        hold on;
        for object_no=1:size(objects_resize,2)
            pts=objects_resize{2,object_no};
            pts=[pts,pts(:,1)];
            hold on;
            plot(pts(1,:),pts(2,:),'-r');
            plotBoxes(h,objects_resize{3,object_no},'-b');
            title(objects_resize{1,object_no});
            pause;
        end
    end
%     keyboard;
    
    record_labelMe{1,i}=just_name;
    record_labelMe{2,i}=objects_resize;
    
    
end


save('record_labelMe_scott.mat','record_labelMe');