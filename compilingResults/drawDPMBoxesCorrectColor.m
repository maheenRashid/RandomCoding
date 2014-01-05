ccc
im_dir='E:\RandomCoding\writingDpmFiles\images_auto';
out_dir='dpm_boxes_all_new_colors';
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end


load('dpm_greater_-1_bbox_record_withDetections');

str_labels={'bed','ns','ct','couch','chair'};
mapping=[1,8,9,2,4];
colors={[0,1,0],[1,0,0],[0.5,0,0],[1,1,0],[1,0.5,0]};
lwidth=3;


models_txt=dir(fullfile(pwd(),'*.txt'));
models_txt={models_txt(:).name};
folders=cellfun(@(x) x(1:end-4),models_txt,'UniformOutput',0);

for folder_no=1:numel(folders)
    folder=folders{folder_no};
    fid=fopen([folder '.txt']);
    models=textscan(fid,'%s','delimiter','\n');
    models=models{1};
    fclose(fid);
    
    
    load(fullfile([folder '_html'],'accuracy_cell_cmp_kept.mat'));
    
    
    for model_no=1:numel(models)
        
        id=models{model_no};
        out_dir=fullfile(folder,id);
        id_trim=regexpi(id,'#','split');
        id_trim=id_trim{end};
        idx_curr=strcmp(id_trim,record(2,:));
        dpms=record(:,idx_curr);
        [dpm_boxes,dpm_cat_no,dpm_bin,dpm_objmap,dpms_str]=getDPMInfoSorted(dpms,mapping,str_labels);
        idx_curr=strcmp(id_trim,accuracy_cell(2,:));
        accu_curr=accuracy_cell{1,idx_curr};
        accu_curr=accu_curr(:,end);
        
        dpm_boxes=dpm_boxes(accu_curr>0,:);
        dpm_cat_no=dpm_cat_no(accu_curr>0);
        im_paths={fullfile(out_dir,'repFinal_justObj.png'),fullfile(im_dir,[id_trim '.jpg']);...
                fullfile(out_dir,'repFinal_justObj_box_kept.png'),fullfile(out_dir,[id_trim '_box_kept.png'])};
        
        for im_path_no=1:size(im_paths,2)
            im=imread(im_paths{1,im_path_no});
            h=figure;
        imshow(im);
        hold on;
        for box_no=1:size(dpm_boxes,1)
            temp=dpm_boxes(box_no,1:4);
            plot(temp([1,1,3,3,1]),temp([2,4,4,2,2]),'-','Color',colors{mapping==dpm_cat_no(box_no)},'linewidth',lwidth);
        end
        hold off;
        
        saveas(h,im_paths{2,im_path_no});
        close(h);
        end
%         keyboard;
        
    end
end




return
ccc



out_dir='dpm_boxes_all_new_colors';
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end


load('dpm_greater_-1_bbox_record_withDetections');

models_txt=dir(fullfile(pwd(),'*.txt'));
models=cell(0,1);
for i=1:numel(models_txt)
    fid=fopen(models_txt(i).name);
    data=textscan(fid,'%s','delimiter','\n');
    data=data{1};
    fclose(fid);
    models=[models;data];
end

problem=cellfun(@isempty,record(end,:));
sum(problem)
record(:,problem)=[];

im_path='E:\RandomCoding\writingDpmFiles\images_auto';

str_labels={'bed','ns','ct','couch','chair'};
mapping=[1,8,9,2,4];
colors={[0,1,0],[1,0,0],[0.5,0,0],[1,1,0],[1,0.5,0]};


for model_no=1:numel(models)
    id=models{model_no};
    id_trim=regexpi(id,'#','split');
    id_trim=id_trim{end};
    idx_curr=strcmp(id_trim,record(2,:));
    dpms=record(:,idx_curr);
    lwidth=3;
    
    [dpm_boxes,dpm_cat_no,dpm_bin,dpm_objmap,dpms_str]=getDPMInfoSorted(dpms,mapping,str_labels);
    
    im=imread(fullfile(im_path,[id_trim '.jpg']));
    h=figure;
    imshow(im);
    hold on;
    for box_no=1:size(dpm_boxes,1)
        temp=dpm_boxes(box_no,1:4);
        plot(temp([1,1,3,3,1]),temp([2,4,4,2,2]),'-','Color',colors{mapping==dpm_cat_no(box_no)},'linewidth',lwidth);
    end
    hold off;
    
    saveas(h,fullfile(out_dir,[id_trim '.png']));
    close(h);
    
    %     keyboard;
end