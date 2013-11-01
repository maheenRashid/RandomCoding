ccc

dir_in_pre='gt_models';
dir_in_post='Img_GT_Features';
show=0;

% load('dpm_greater_-1_bbox_record.mat');
load('dpm_greater_-1_bbox_record.mat')
load('gt_list.mat')


cat_dpm=unique(record(1,:));
d_table_bin=strcmp('diningtable',record(1,:));
record(:,d_table_bin)=[];
record=[record;cell(2,size(record,2))];


for gt_no=1:numel(gt_list)
    
    name_curr=gt_list{gt_no};
    if numel(find(strcmp(name_curr,errorLog)))>0
        continue;
    end
    
    %find dpm detections
    name_dpm=regexpi(name_curr,'#','split');
    name_dpm=name_dpm{end};
    dpm_curr=strcmp(name_dpm,record(2,:));
    idx_dpm_curr=find(dpm_curr);
    dpm_curr=record(:,dpm_curr);
    dpm_cat_no=getMapping(dpm_curr(1,:));
    
    bbox_gt=boxes_and_labels_all(:,gt_no);
    gt_boxes=bbox_gt{1};
    gt_cat_varsha=bbox_gt{2};
    
    bin_detect_all=cell(1,numel(dpm_cat_no));
    for i=1:numel(dpm_cat_no)
        matchToGt=dpm_cat_no(i)==gt_cat_varsha
        matchToGt=find(matchToGt)
        
        dpm_boxes_curr=dpm_curr{3,i};
        bin_detect_curr=zeros(size(dpm_boxes_curr,1),1);
        
        if numel(matchToGt)~=0
            for dpm_box_no=1:size(dpm_boxes_curr,1)
                dpm_box_curr=dpm_boxes_curr(dpm_box_no,1:4);
                for gt_box_no=1:numel(matchToGt)
                    gt_box_curr=gt_boxes(matchToGt(gt_box_no),:);

                    if show>0
                        h=figure;
                        imshow(imread(fullfile(dir_in_pre,name_curr,dir_in_post,'object_mask_overlay.png')));
                    
                    bin=isDetection(dpm_box_curr,gt_box_curr,show,h);
                    
                        pause;
                    else
                    bin=isDetection(dpm_box_curr,gt_box_curr);
                        
                    end
                    
                    
                    if bin>0
                        break
                    end
                    
                end
                bin_detect_curr(dpm_box_no)=bin;
            end
        end
        
        bin_detect_all{i}=bin_detect_curr;
    end
    record(4,idx_dpm_curr)=bin_detect_all;
    record(5,idx_dpm_curr)=num2cell(dpm_cat_no);
    idx_dpm_curr
    record(:,idx_dpm_curr)
    
%     keyboard;
end

save('dpm_greater_-1_bbox_record_withDetections.mat')
