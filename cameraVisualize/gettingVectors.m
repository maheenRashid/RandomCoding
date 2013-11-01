ccc
cam_dir='E:/gt_cam';
comp_dir='mergedComp_ultimate';

load(fullfile(cam_dir,'all_cams.mat'));
load('predAndFileNamesCompiled_ultimate.mat');

show=0;

cam_names=getNamesFromStruct(cams);
for i=1:numel(cam_names)
    name_curr=cam_names{i};
    name_curr=regexpi(name_curr,'#','split');
    name_curr=name_curr{end};
    cam_names{i}=name_curr;
end


for cat_no=9:16
dir_comp=fullfile(comp_dir,num2str(cat_no));
pred_cat=predAndDirCell{1,cat_no};
pred_cat_names=predAndDirCell{2,cat_no};

% [pred_cat,unique_idx]=unique(pred_cat);
% pred_cat_names=pred_cat_names(unique_idx);


camVecsAndPred=cell(3,numel(pred_cat_names));
for i=1:numel(pred_cat_names)
%     justName=pred_cat_names{i}(1:end-6);
    temp_idx = strfind( pred_cat_names{i}, '_');
    justName=pred_cat_names{i}(1:temp_idx(end)-1);
    
    pred_curr=pred_cat(i);
    cam_idx=strcmp(justName,cam_names);
    cam_idx=find(cam_idx);
    
    if numel(cam_idx)~=1
        keyboard
    end
    
    load(fullfile(dir_comp,pred_cat_names{i}));
    [pt_back,pt_front]=getBackAndFrontMiddle(mergedA,pred_curr);
    pts=[pt_back,pt_front];
    [ pts_t ] = transformToCameraCoordinates( cams(cam_idx).eye,cams(cam_idx).ref,cams(cam_idx).up,pts );
    camVecsAndPred{1,i}=pred_cat_names{i};
    camVecsAndPred{2,i}=pred_curr;
    camVecsAndPred{3,i}=pts_t;
    
    if show>0
        h=figure;
        pts(3,:)=100;
        if numel(cam_idx)~=1
            keyboard;
        end
        visualizeCam(h,cams(cam_idx).eye,cams(cam_idx).ref,cams(cam_idx).up);
        load(fullfile(dir_comp,pred_cat_names{i}));
        display3DComp(h,mergedA);
        hold on;
        plot3(pts(1,:),pts(2,:),pts(3,:),'-y','linewidth',5);
        plot3(pts(1,1),pts(2,1),pts(3,1),'oy','linewidth',5);
        plot3(pts(1,2),pts(2,2),pts(3,2),'om','linewidth',5);
        
        axis equal
        xlabel('x')
        ylabel('y')
        pause;
    end
end
save(fullfile(dir_comp,'camVecsAndPred.mat'),'camVecsAndPred');
end