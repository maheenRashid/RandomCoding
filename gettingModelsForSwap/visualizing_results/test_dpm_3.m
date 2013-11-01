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

prec=zeros(numel(folders),3);
prec_cat=zeros(numel(folders),numel(det_to_check),3);

for folder_no=1:numel(folders)
    folder=folders{folder_no};
    
    load(fullfile(parent_dir,folder,'record_detections_dpm.mat'));
    
    
    for mod_no=1:numel(record_detections)
        
        model_name=record_detections(mod_no).id_name;
        dpm_boxes=record_detections(mod_no).dpm_boxes;
        det_boxes=record_detections(mod_no).boxes;
        bin_visibility=record_detections(mod_no).bin_visibility;
        det_overlap=record_detections(mod_no).dpm_bbox_overlap;
        det_cat=record_detections(mod_no).cat_no_aft;
        dpm_cat=record_detections(mod_no).dpm_cat_no;
        dpm_bin=record_detections(mod_no).dpm_bin;
        if numel(dpm_bin)==0
            continue;
        end
        
        
        %for every det box get the gt boxes of same cat
        %thresh them
        %create bin
        
        bin_dpm_det=zeros(size(dpm_cat));
        conf=zeros(size(dpm_cat));
        overlap=zeros(size(dpm_cat));
        
        for dpm_no=1:numel(dpm_cat)
            overlaps=det_overlap(dpm_no,:);
            overlaps(~bin_visibility)=0;
            [max_overlap,idx_max]=max(overlaps,[],2);
            conf(dpm_no)=det_cat(idx_max);
            overlap(dpm_no)=max_overlap;
            if max_overlap>thresh && dpm_cat(dpm_no)==det_cat(idx_max)
                bin_dpm_det(dpm_no)=1;
            end
        end
        
        
        
        record_detections(mod_no).bin_dpm_det=bin_dpm_det;
        record_detections(mod_no).conf=conf;
        record_detections(mod_no).overlap=overlap;
        
        
        
        
        if numel(bin_dpm_det)~=numel(dpm_bin)
            keyboard;
        end
        
        
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
            
            h=figure;imshow(im);
            
            for i=1:size(dpm_boxes,1)
                if bin_dpm_det(i)>0
                    plotBoxes(h,dpm_boxes(i,:),'-b',2);
                else
                    plotBoxes(h,dpm_boxes(i,:),'-g',2);
                end
            end
            
            keyboard;
            close all;
        end
        
    end
    
    bin_dpm_truth={record_detections(:).dpm_bin};
    mod_idx=(~cellfun(@isempty,bin_dpm_truth));
    
    bin_dpm_truth=bin_dpm_truth(mod_idx);
    dpm_cat_all={record_detections(mod_idx).dpm_cat_no};
    
    dpm_cat_all_vec=cell2mat(dpm_cat_all');
    
    
    bin_dpm_det_all=cell2mat({record_detections(mod_idx).bin_dpm_det}');
    bin_dpm_truth=cell2mat(bin_dpm_truth');
    
    overall=sum(bin_dpm_truth==bin_dpm_det_all)/numel(bin_dpm_truth)
    pos=sum(bin_dpm_truth==bin_dpm_det_all & bin_dpm_truth==1)/sum(bin_dpm_truth==1)
    neg=sum(bin_dpm_truth==bin_dpm_det_all & bin_dpm_truth==0)/sum(bin_dpm_truth==0)
    
    prec(folder_no,1)=overall;
    prec(folder_no,2)=pos;
    prec(folder_no,3)=neg;
    
    for det_no=1:numel(det_to_check)
        cat_curr=det_to_check(det_no);
        prec_cat(folder_no,det_no,1)=sum(bin_dpm_truth==bin_dpm_det_all & dpm_cat_all_vec==cat_curr)/sum(dpm_cat_all_vec==cat_curr);
        prec_cat(folder_no,det_no,2)=sum(bin_dpm_truth==bin_dpm_det_all & dpm_cat_all_vec==cat_curr & bin_dpm_truth==1)/sum(dpm_cat_all_vec==cat_curr & bin_dpm_truth==1);
        prec_cat(folder_no,det_no,3)=sum(bin_dpm_truth==bin_dpm_det_all & dpm_cat_all_vec==cat_curr & bin_dpm_truth==0)/sum(dpm_cat_all_vec==cat_curr & bin_dpm_truth==0);
    end
end

save('new_labels_accu_dpm_refine.mat');