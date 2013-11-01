ccc

results_dir='/home/maheenr/results_temp_09_13';
folders={'3dnn_gt','3dnn_auto'};
for folder_no=1:numel(folders)
    dir_im=fullfile(results_dir,folders{folder_no});
    out_dir=[dir_im '_html'];
    if ~exist(out_dir,'dir')
        mkdir(out_dir);
    end
    
    dir_curr=dir(dir_im);
    dir_curr=dir_curr(3:end);
    
    detections_struct=struct();
    error_struct=struct();
    
    matlabpool open
    parfor im_no=1:numel(dir_curr)
        dir_sun=fullfile(dir_im,dir_curr(im_no).name,'renderings')
        if ~exist(fullfile(dir_sun,'raw_cat_mask.png'),'file')
            error_struct(im_no).name=dir_sun;
            continue
        end
        im_cat=imread(fullfile(dir_sun,'raw_cat_mask.png'));
        im_obj=imread(fullfile(dir_sun,'raw_object_mask.png'));
        sun_id =regexpi(dir_curr(im_no).name,'#','split');
        sun_id=sun_id{end};
        
        %get group ids;
        group_ids=unique(im_obj);
        group_ids(group_ids==0)=[];
        
        cell_curr=cell(4,numel(group_ids));
        
        
        [cell_curr{2,:}]=deal(sun_id);
        
        for id_no=1:numel(group_ids)
            %get association;
            id_curr=group_ids(id_no);
            id_bin=im_obj==id_curr;
            cat_curr=im_cat(id_bin);
            cat_id=mode(double(cat_curr));
            cell_curr{1,id_no}=cat_id;
            cell_curr{4,id_no}=id_curr;
            %get min max
            [x,y]=find(im_cat==cat_id & id_bin);
            xy=[y,x];
            mins=min(xy,[],1);
            maxs=max(xy,[],1);
            box=[mins,maxs];
            cell_curr{3,id_no}=box;
            
            
        end
        detections_struct(im_no).cell_curr=cell_curr;
    end
    matlabpool close
    
    detections=cell(4,0);
    for det_no=1:numel(detections_struct)
        detections=[detections detections_struct(det_no).cell_curr];
    end
    
    save(fullfile(out_dir,'detections.mat'));
end