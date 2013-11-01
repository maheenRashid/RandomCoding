ccc
im_dir='images_auto';
% out='dpm_prune';
% thresh_abs=-0.5;

out='dpm_greater_-1';
thresh_abs=-1;
if ~exist(out,'dir')
    mkdir(out);
end
org=fullfile('detections_auto_images');

cat=getNamesFromDir( org );
bl=getNamesFromDir( fullfile(org,cat{1}) );

for cat_no=1:numel(cat)
    cat{cat_no}
    %     :numel(cat)
    if ~exist(fullfile(out,cat{cat_no}),'dir')
        mkdir(fullfile(out,cat{cat_no}));
    end
    
    for bl_no=1:numel(bl)
        mat_names=getNamesFromDir(fullfile(org,cat{cat_no},bl{bl_no}));
        out_curr=fullfile(out,cat{cat_no},bl{bl_no});
        if ~exist(out_curr,'dir')
            mkdir(out_curr);
        end
        for mat_no=1:numel(mat_names)
            
            mat_curr=mat_names{mat_no};
            sun_id=regexpi(mat_curr,'[\.]','split');
            
            load(fullfile(org,cat{cat_no},bl{bl_no},mat_curr));
            if numel(bbox)>1
                keyboard;
            end
            
            top_idx=top{1};
            if numel(top_idx)==0
                continue
            end
            conf_top=bbox{1}(top_idx,end);
            top_idx=top_idx(conf_top>thresh_abs);
            conf_top=conf_top(conf_top>thresh_abs);
            if numel(top_idx)~=0
                bbox_top=bbox{1}(top_idx,:);
            else
                continue;
            end
            sun_id=sun_id{1};
            im=imread(fullfile(im_dir,[sun_id '.jpg']));
            h=figure;
            imshow(im);
            for i=1:size(bbox_top,1)
                plotBoxes(h,bbox_top(i,1:4),'-r');
            end
            set(h,'visible','off');
            save(fullfile(out_curr,mat_curr));
            saveas(h,fullfile(out_curr,[sun_id '.jpg']));
            close all
%             pause;
        end
    end
end
