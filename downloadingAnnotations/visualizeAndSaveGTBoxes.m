ccc

load('record_labelMe_combined.mat');
im_dir='E:\RandomCoding\writingDpmFiles\gt_models';
out_dir='labelMe_gt_im';
mapping ={'bed','chair','ns','couch','ct'};
strs={'-r','-g','-b','-m','-y'};

if ~exist(out_dir,'dir')
    mkdir(out_dir);
end

% check=record_labelMe(2,:);
% check=cellfun(@(x) numel(x)==1,check);
% record_labelMe(:,check)=[];
% save('record_labelMe_combined.mat','record_labelMe');

for i=142:size(record_labelMe,2)
    i
    objects_resize=record_labelMe{2,i};
    im=imread(fullfile(im_dir,record_labelMe{1,i},'resized_image.jpg'));
    h=figure;
    imshow(im);
    hold on;
    for object_no=1:size(objects_resize,2)
        pts=objects_resize{2,object_no};
        pts=[pts,pts(:,1)];
        hold on;
        str_curr=strs{strcmp(objects_resize{1,object_no},mapping)};
        plot(pts(1,:),pts(2,:),str_curr,'linewidth',1);
        plotBoxes(h,objects_resize{3,object_no},str_curr,2);
        title(objects_resize{1,object_no});
%         pause;
    end
    title(record_labelMe{1,i});
    set(h,'visible','off');
    saveas(h,fullfile(out_dir,[record_labelMe{1,i} '.png']));
    close(h);
    
end
