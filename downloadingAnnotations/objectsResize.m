function [objects_resize]=objectsResize(data_curr,size_im_dpm)
    if ~isfield(data_curr.annotation,'object')
        objects_resize=-1
        return
    end
    size_im_web=size_im_dpm;
    
    size_im_web(1)=str2double(data_curr.annotation.imagesize.nrows);
    size_im_web(2)=str2double(data_curr.annotation.imagesize.ncols);
    
    objects=cell(3,numel(data_curr.annotation.object));
    
    for object_no=1:numel(data_curr.annotation.object)
        objects{1,object_no}=data_curr.annotation.object(object_no).name;
        objects{2,object_no}=[data_curr.annotation.object(object_no).polygon.x';data_curr.annotation.object(object_no).polygon.y'];
        
    end
    
    resize_val=size_im_dpm./size_im_web;
    resize_val=resize_val(1:2);
    resize_val=[resize_val(1),0,0;0,resize_val(2),0;0,0,1];
    
    objects_resize=objects;
    for object_no=1:size(objects_resize,2)
        pts=objects_resize{2,object_no};
        pts=[pts;ones(1,size(pts,2))];
        pts_resize=resize_val*pts;
        pts_resize=pts_resize./repmat(pts_resize(end,:),size(pts_resize,1),1);
        pts_resize=pts_resize(1:2,:);
        objects_resize{2,object_no}=pts_resize;
        mins=min(pts_resize,[],2);
        maxs=max(pts_resize,[],2);
        mins_maxs=[mins,maxs];
        mins_maxs=mins_maxs(:);
        mins_maxs=mins_maxs';
        objects_resize{3,object_no}=mins_maxs;
    
    end


end