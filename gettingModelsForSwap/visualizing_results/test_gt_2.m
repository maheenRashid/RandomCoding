ccc

meta_dir='E:/RandomCoding';
im_dir=fullfile(meta_dir,'writingDpmFiles/gt_models');


parent_dir= 'E:\RandomCoding\gettingModelsForSwap\visualizing_results';

folders=dir(fullfile(pwd(),'swapModelInBox_newLabels*refine_html'));
folders={folders(:).name};
% return
% folder='swapModelInBox_newLabels_bestSortedByDPMScore_auto_html';




show=0;
thresh=0.5;
det_to_check=[1,2,4,8,9];

prec=zeros(numel(folders),numel(det_to_check));


for folder_no=1:numel(folders)
folder=folders{folder_no};

load(fullfile(parent_dir,folder,'record_detections_gt.mat'));

for mod_no=1:numel(record_detections)
    
    model_name=record_detections(mod_no).id_name;
    gt_boxes=record_detections(mod_no).gt_boxes;
    det_boxes=record_detections(mod_no).boxes;
    bin_visibility=record_detections(mod_no).bin_visibility;
    det_overlap=record_detections(mod_no).bbox_overlap;
%     det_overlap=record_detections(mod_no).pixelwise_overlap;
    
    det_cat=record_detections(mod_no).cat_no_aft;
    gt_cat=record_detections(mod_no).gt_cat_no;
    
    if numel(gt_cat)==0
        continue;
    end
    
    
    %for every det box get the gt boxes of same cat
    %thresh them
    %create bin
    
    bin_empty_curr=zeros(size(det_cat));
    bin_det=zeros(size(det_cat));
    conf=zeros(size(det_cat));
    overlap=zeros(size(det_cat));
    
    for det_no=1:numel(det_cat)
        if numel(det_boxes{det_no})==0
            bin_empty_curr(det_no)=1;
        end
        
%         obj_idx=det_cat(det_no)==gt_cat;
%         overlaps=det_overlap(obj_idx,det_no);
        
        
        overlaps=det_overlap(:,det_no);
        [max_overlap,idx_max]=max(overlaps,[],1);
            conf(det_no)=gt_cat(idx_max);
            overlap(det_no)=max_overlap;
        
        
        if max_overlap>thresh && gt_cat(idx_max)==det_cat(det_no)
            bin_det(det_no)=1;
        end
        
    end
    
    
    
    record_detections(mod_no).bin_empty=bin_empty_curr;
    record_detections(mod_no).bin_det=bin_det;
    record_detections(mod_no).conf=conf;
    record_detections(mod_no).overlap=overlap;
    
    
    
    if show>0
        im=imread(fullfile(im_dir,model_name,'raw_image.jpg'));
        h=figure;imshow(im);
        for i=1:numel(gt_boxes)
            plotBoxes(h,gt_boxes{i},'-r',2);
        end
        
        for i=1:numel(det_boxes)
            if numel(det_boxes{i})==0
                continue
            end
            if bin_det(i)>0
                plotBoxes(h,det_boxes{i},'-b',2);
            else
                plotBoxes(h,det_boxes{i},'-g',2);
            end
        end
        
        keyboard;
        close all;
    end
    
end

gt_cat_all={record_detections(:).gt_cat_no};
mod_idx=(~cellfun(@isempty,gt_cat_all));


bin_det_all=cell2mat({record_detections(mod_idx).bin_det}');
det_cat_all=cell2mat({record_detections(mod_idx).cat_no_aft}');
bin_empty_all=cell2mat({record_detections(mod_idx).bin_empty}');
bin_visibility_all=cell2mat({record_detections(mod_idx).bin_visibility}');




for i=1:numel(det_to_check)
    prec(folder_no,i)=sum(bin_det_all>0 & bin_empty_all<1 & det_cat_all==det_to_check(i) & bin_visibility_all>0)/sum(bin_empty_all<1 & det_cat_all==det_to_check(i) & bin_visibility_all>0);
end
end

save('new_labels_accu_gt_refine.mat');