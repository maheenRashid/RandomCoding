ccc
load('D:\3DGP\indoorunderstanding_3dgp-master\maheen_code\stats_cat.mat');
im_dir='images_auto';
txt_dir='dpm_cat_all';
show=1;


cats_3DGP=unique(record(1,:));
bin=strcmp(cats_3DGP{3},record(1,:));
record(:,bin)=[];
cats_3DGP=cats_3DGP([1,2,4,5,6]);
mapping =[1,4,8,2,9];

strs={'-r','-g','-b','-m','-y'};
name_model=unique(record(2,:));

for model_no=1:numel(name_model)
    name_curr=name_model{model_no};
    name_id=regexpi(name_curr,'#','split');
    name_id=name_id{end}
    
    bin=strcmp(name_curr,record(2,:));
    cat_curr=record(1,bin);
    bb_curr=record(3,bin);
    bb_curr=bb_curr';
    bb_curr=cell2mat(bb_curr);
    [val,idx]=sort(bb_curr(:,end),'descend');
    bb_curr=bb_curr(idx,:);
    cat_curr=cat_curr(idx);
    
    
    
    cell2print=cell(2,size(bb_curr,1));
    for i=1:size(bb_curr,1)
        cell2print{2,i}=getBoxPts(bb_curr(i,:));
        cell2print{1,i}=mapping(strcmp(cat_curr{i},cats_3DGP));
    end
    fname=fullfile(txt_dir,[name_id '.txt']);
%     write_dpm(fname,cell2print);
    
    if show>0
        im=imread(fullfile(im_dir,[name_id '.jpg']));
        h=figure;
        imshow(im);
        for i=1:size(bb_curr,1)
            plotBoxes(h,bb_curr(i,:),strs{strcmp(cat_curr{i},cats_3DGP)});
            bb_curr(i,:)
            cat_curr{i}
            pause;
        end
        keyboard;
    end
end

