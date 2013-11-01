ccc

meta_dir='E:/RandomCoding';
im_dir=fullfile(meta_dir,'writingDpmFiles/gt_models');


parent_dir= 'E:\RandomCoding\gettingModelsForSwap\visualizing_results';
folder='swapModelInBox_bestSortedByDPMScore_auto_html';
load(fullfile(parent_dir,folder,'record_detections_dpm.mat'));

% return
show=1;
thresh=0.3;

% bin_empty=cell(size(record_detections));
% bin_visibility=cell(size(record_detections));
% conf_all=cell(size(record_detections));
% overlap_all=cell(size(record_detections));
% bin_det_all=cell(size(record_detections));

for mod_no=1:numel(record_detections)
    
    model_name=record_detections(mod_no).id_name;
    dpm_boxes=record_detections(mod_no).dpm_boxes;
    det_boxes=record_detections(mod_no).boxes;
    bin_visibility=record_detections(mod_no).bin_visibility;
    det_overlap=record_detections(mod_no).dpm_bbox_overlap;
    det_cat=record_detections(mod_no).cat_no_aft;
    dpm_cat=record_detections(mod_no).dpm_cat_no;
    
    if numel(dpm_cat)==0
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
        
        overlaps=det_overlap(:,det_no);
        [max_overlap,idx_max]=max(overlaps,[],1);
        
        %         if max_overlap>thresh
        conf(det_no)=dpm_cat(idx_max);
        overlap(det_no)=max_overlap;
        %         end
        
        
        if max_overlap>thresh && dpm_cat(idx_max)==det_cat(det_no)
            bin_det(det_no)=1;
        end
        
        %         det_cat_curr=det_cat(det_no);
        %         dpm_idx=find(dpm_cat==det_cat_curr);
        %         if sum(dpm_idx)==0
        %             continue
        %         end
        
        
    end
    
    
    
    record_detections(mod_no).bin_empty=bin_empty_curr;
    record_detections(mod_no).bin_det=bin_det;
    record_detections(mod_no).conf=conf;
    record_detections(mod_no).overlap=overlap;
    
    
    dpm_bin=record_detections(mod_no).dpm_bin;
    
    if show>0
        im=imread(fullfile(im_dir,model_name,'raw_image.jpg'));
        h=figure;imshow(im);
        %             hold on;
        for i=1:size(dpm_boxes,1)
            if dpm_bin(i)>0
                plotBoxes(h,dpm_boxes(i,:),'-r',2);
            else
                plotBoxes(h,dpm_boxes(i,:),'-k',2);
            end
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

% dpm_cat_all={record_detections(:).dpm_cat_no};
% mod_idx=(~cellfun(@isempty,dpm_cat_all));
% 
% 
% bin_det_all=cell2mat({record_detections(mod_idx).bin_det}');
% det_cat_all=cell2mat({record_detections(mod_idx).cat_no_aft}');
% bin_empty_all=cell2mat({record_detections(mod_idx).bin_empty}');
% bin_visibility_all=cell2mat({record_detections(mod_idx).bin_visibility}');
% 
% 
% det_to_check=[1,2,4,8,9];
% for i=1:numel(det_to_check)
%     det_to_check(i)
%     sum(bin_det_all>0 & bin_empty_all<1 & det_cat_all==det_to_check(i) & bin_visibility_all>0)/sum(bin_empty_all<1 & det_cat_all==det_to_check(i) & bin_visibility_all>0)
% end
