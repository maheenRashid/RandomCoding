ccc

meta_dir='E:/RandomCoding';

folders={'3dnn_gt_html','3dnn_auto_html'};

for folder_no=1:numel(folders)
    
    load(fullfile(meta_dir,'accuracy_for_3dnn',folders{folder_no},'detections.mat'),'detections');
    out_dir=folders{folder_no};
    
    record=detections;
    lab_nos=[8,9,10,11,12];
    ia=ismember(cell2mat(detections(1,:)),lab_nos);
    record=detections(:,ia);
    lab_nos_rec=cell2mat(record(1,:));
    lab_str={'bed','couch','chair','ct','ns'};
    lab_str_rec=cell(1,size(record,2));
    
    for i=1:numel(lab_nos)
        bin=lab_nos_rec==lab_nos(i);
        [lab_str_rec{bin}]=deal(lab_str{i});
    end
    record(1,:)=lab_str_rec;
    
    
    load(fullfile(meta_dir,'downloadingAnnotations','record_labelMe_combined.mat'));
    strs_for_cmp=cell(1,size(record_labelMe,2));
    for i=1:numel(strs_for_cmp)
        temp=regexpi(record_labelMe{1,i},'#','split');
        strs_for_cmp{i}=temp{end};
    end
    
    
    record=[record;cell(2,size(record,2))];
    
    show=0;
    im_dir=fullfile(meta_dir,'writingDpmFiles/gt_models');
    errorLog=zeros(1,0);
    for im_no=1: size(record,2)
        
        idx_labelMe_curr=strcmp(record{2,im_no},strs_for_cmp);
        record_labelMe_curr=record_labelMe(:,idx_labelMe_curr);
        
        if size(record_labelMe_curr,2)~=1
            errorLog=[errorLog im_no];
            continue;
        end
        
        obj_gt=record_labelMe_curr{2};
        bin_curr_gt=zeros(1,size(obj_gt,2));
        dpms_curr=record{3,im_no};
        dpm_lab=record{1,im_no};
        idx_obj_gt_curr=find(strcmp(dpm_lab,obj_gt(1,:)));
        obj_gt_curr=obj_gt(:,idx_obj_gt_curr);
        
        bin=zeros(size(dpms_curr,1),1);
        obj_gt_nos=zeros(size(dpms_curr,1),1);
        for dpm_no=1:numel(bin)
            box_dpm=dpms_curr(dpm_no,1:4);
            bin_curr=0;
            for obj_no=1:size(obj_gt_curr,2)
                box_gt=double(obj_gt_curr{3,obj_no});
                bin_curr=isDetection(box_dpm,box_gt);
                
                if bin_curr>0
                    obj_gt_nos(dpm_no)=obj_no;
                    bin_curr_gt(idx_obj_gt_curr(obj_no))=bin_curr;
                    break
                end
            end
            bin(dpm_no)=bin_curr;
        end
        
        bin_curr_gt=num2cell(bin_curr_gt,1);
        obj_gt=[obj_gt;bin_curr_gt];
        record_labelMe{2,idx_labelMe_curr}=obj_gt;
        
        str_bin={'-k','-r'};
        
        if show>0
            im=imread(fullfile(im_dir,record_labelMe_curr{1},'raw_image.jpg'));
            h=figure;imshow(im);
            for dpm_no=1:numel(bin)
                plotBoxes(h,dpms_curr(dpm_no,1:4),str_bin{bin(dpm_no)+1});
            end
           pause;
        end

        record{end-1,im_no}=bin;
        record{end,im_no}=obj_gt_nos;
        debug_det=record(:,im_no);
        debug_gt=record_labelMe{2,idx_labelMe_curr};
%         keyboard;
%         close all
    end
    
    
for i=1:size(record_labelMe,2)
cell_curr=record_labelMe{2,i};
if numel(cell_curr)==0 || size(cell_curr,1)==4
continue
end
a=cell2mat(cell_curr(4:end,:));
a=sum(a,1);
a=a>0;
cell_curr(4:end,:)=[];
cell_curr=[cell_curr;num2cell(a,1)];
record_labelMe{2,i}=cell_curr;
end
    
    
    
    save(fullfile(out_dir,'detections_withBin.mat'),'record','record_labelMe','errorLog');
end