% ccc
% load('D:\3DGP\indoorunderstanding_3dgp-master\maheen_code\stats_cat.mat');
load('dpm_greater_-1_bbox_record.mat')
% load('dpm_bbox_record.mat')
im_dir='images_auto';
im_out='im_dpm_greater_-1';
if ~exist(im_out,'dir')
    mkdir(im_out);
end
txt_dir='dpm_cat_all_greater_-1';
show=1;

if ~exist(txt_dir,'dir')
    mkdir(txt_dir);
end

cats_3DGP=unique(record(1,:));
bin=strcmp(cats_3DGP{3},record(1,:));
record(:,bin)=[];
cats_3DGP=cats_3DGP([1,2,4,5,6]);
% mapping =[1,4,8,2,9];
% 
% strs={'-r','-g','-b','-m','-y'};
% return
name_model=unique(record(2,:));


matlabpool open
for model_no=1:numel(name_model)
    model_no
    name_curr=name_model{model_no};
    name_id=regexpi(name_curr,'#','split');
    name_id=name_id{end}
    
    bin=strcmp(name_curr,record(2,:));
    cat_curr=record(1,bin);
    
    bb_curr=record(3,bin);
    
    bb_curr=bb_curr';
    cell2print=cell(2,0);
    for cat_no=1:numel(bb_curr)
        cell_curr=cell(2,size(bb_curr{cat_no},1));
        for box_no=1:size(bb_curr{cat_no},1)
            cell_curr{1,box_no}=mapping(strcmp(cat_curr{cat_no},cats_3DGP));
            cell_curr{2,box_no}=bb_curr{cat_no}(box_no,:);
        end
        cell2print=[cell_curr cell2print];
%         keyboard;
    end
    
    bb_curr=cell2mat(cell2print(2,:)');
    [val,idx]=sort(bb_curr(:,end),'descend');
    cell2print=cell2print(:,idx);
    cell2print_bbox=cell2print(2,:);
    
    for i=1:size(cell2print,2)
        cell2print{2,i}=getBoxPts(cell2print{2,i});
    end
    fname=fullfile(txt_dir,[name_id '.txt']);
    write_dpm(fname,cell2print);
    
    if show>0
        im=imread(fullfile(im_dir,[name_id '.jpg']));
        h=figure;
        imagesc(im);
        axis off;
        axis equal;
        for i=1:size(cell2print,2)
            plotBoxes(h,cell2print_bbox{1,i},strs{cell2print{1,i}==mapping});
            cell2print{2,i};
            cell2print{1,i};
%             pause;
        end
%         keyboard;
        saveas(h,fullfile(im_out,[name_id '.jpg']));
        close(h);
    end
end

matlabpool close