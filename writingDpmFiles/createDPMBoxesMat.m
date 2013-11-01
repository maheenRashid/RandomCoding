% ccc
% load('temp.mat');
% [ bin,count,obj ] = getDetection( bbox_top,im_cat )
% return
ccc
im_dir='images_auto';
im_list=getNamesFromDir(im_dir);

% dir_dpm='dpm_prune';

dir_dpm='dpm_greater_-1';

cat=getNamesFromDir( dir_dpm );
bl=getNamesFromDir( fullfile(dir_dpm,cat{1}) );
record=cell(3,0);
show=0;
for im_no=1:numel(im_list)
    for cat_no=1:numel(cat)
        im_no
        cat_no
        mod_curr=im_list{im_no};
        mod_curr=regexpi(mod_curr,'[\.]','split');
        mod_curr=mod_curr{1};
        filename=fullfile(dir_dpm,cat{cat_no},bl{1},[mod_curr '.mat']);
        
        if ~exist(filename,'file')
            continue;
        end
        
        load(filename,'bbox_top');
        
        temp={cat{cat_no};mod_curr;bbox_top};
        record=[record temp];
        
        %         figure;
        %         subplot(1,2,1);
        %         imagesc(im_cat)
        %         subplot(1,2,2);
        %         im_lab=bwlabel(im_cat);
        %         max(max(im_lab))
        %         imagesc(im_lab)
%         keyboard
        if show>0
            h=figure;
            imshow(imread(fullfile(im_dir,im_list{im_no})));
            for box_no=1:size(bbox_top,1)
                plotBoxes(h,bbox_top(box_no,:),'-r');
            end
            keyboard;
            close all; clc;
        end
    end
    save([dir_dpm '_bbox_record.mat'],'record');
end
save([dir_dpm '_bbox_record.mat'],'record');