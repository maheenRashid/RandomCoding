
load(fullfile(dir_parent,[folder '_html'],'relevant_files.mat'),'relevant_files');
% load(fullfile(dir_parent,['gt_raw' '_html'],'record_new_labels_bad_names_in.mat'),'record_new_labels');
load(fullfile(dir_parent,['gt_raw' '_html'],'record_new_labels_with_new_cat.mat'),'record_new_labels');

names={record_new_labels(1:end).name};
idx=find(~cellfun(@isempty,names));
names={record_new_labels(idx).name};
group_ids={record_new_labels(idx).group_ids};
cat_no_aft={record_new_labels(idx).cat_no_aft_no_minus};

record_detections=struct();
errorLog=struct('name',[]);

matlabpool open
parfor mod_no=1:size(relevant_files,2)
    
    
    
    files_curr=relevant_files(:,mod_no);
    
    fullpath=files_curr{end};
    str_split=regexpi(fullpath,'/','split');
    match_name=str_split{end-1};
    id_name=str_split{end-3};
    box_no=str_split{end-2};
    
    
    im_obj=imread(fullfile(fullpath,files_curr{4}));
    im_normal_walls=rgb2gray(imread(fullfile(fullpath,files_curr{1})));
    im_normal_obj=rgb2gray(imread(fullfile(fullpath,files_curr{2})));
    
    idx=strcmp(match_name,names);
    if sum(idx)==0
        errorLog(mod_no).name=match_name;
        continue
    end
    
    group_id_curr=group_ids{idx};
    cat_no_aft_curr=cat_no_aft{idx};
    
    masks=cell(numel(group_id_curr),1);
    boxes=cell(numel(group_id_curr),1);
    bin_visibility=zeros(numel(group_id_curr),1)>0;
    
    
    for i=1:numel(group_id_curr)
        mask_curr=group_id_curr(i)==im_obj;
        [y,x]=find(mask_curr);
        mins=min([x,y],[],1);
        maxs=max([x,y],[],1);
        bbox=[mins,maxs];
        
        withObj=im_normal_walls(mask_curr);
        withoutObj=im_normal_obj(mask_curr);
        bin_visibility(i)=~isequal(withObj,withoutObj);
        
        masks{i}=mask_curr;
        boxes{i}=bbox;
        
    end
    
    record_detections(mod_no).id_name=id_name;
    record_detections(mod_no).box_no=box_no;
    record_detections(mod_no).match_name=match_name;
    record_detections(mod_no).group_id=group_id_curr;
    record_detections(mod_no).cat_no_aft=cat_no_aft_curr;
    record_detections(mod_no).boxes=boxes;
    record_detections(mod_no).masks=masks;
    record_detections(mod_no).bin_visibility=bin_visibility;
    
end
matlabpool close

save(fullfile(dir_parent,[folder '_html'],'record_detections.mat'),'record_detections','errorLog');







