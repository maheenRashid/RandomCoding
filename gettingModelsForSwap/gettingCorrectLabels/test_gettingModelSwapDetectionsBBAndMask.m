ccc
fullpath='temp';
load(fullfile(fullpath,'test_files.mat'));
load('record_new_labels.mat');

names={record_new_labels(1:end).name};
idx=find(~cellfun(@isempty,names));

% record_new_labels=record_new_labels(idx);

% return
names={record_new_labels(idx).name};
group_ids={record_new_labels(idx).group_ids};
cat_no_aft={record_new_labels(idx).cat_no_aft};


%just to make porting to server easy
relevant_files=test_files;
%convert to loop later

record_detections=struct();


mod_no=1;



files_curr=relevant_files(:,mod_no);

full_path=files_curr{end};
str_split=regexpi(full_path,'/','split');
match_name=str_split{end-1};
id_name=str_split{end-2};

idx=strcmp(match_name,names);
group_id_curr=group_ids{idx};
cat_no_aft_curr=cat_no_aft{idx};

group_id_curr(group_id_curr==0)=[];
masks=cell(numel(group_id_curr),1);
boxes=cell(numel(group_id_curr),1);
bin_visibility=zeros(numel(group_id_curr),1)>0;

im_obj=imread(fullfile(fullpath,files_curr{4}));
im_normal_walls=rgb2gray(imread(fullfile(fullpath,files_curr{1})));
im_normal_obj=rgb2gray(imread(fullfile(fullpath,files_curr{2})));

%%%%%%%%%%
figure; imagesc(im_obj); axis off;
figure; imshow(im_normal_walls);
figure; imshow(im_normal_obj);

h=figure;
h_normal=figure;
%%%%%%%%%%

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
    
    
    
    
    
    %%%%%%%%%%
    figure(h_normal);
    subplot(1,2,1);
    imshow(im_normal_walls.*uint8(double(mask_curr)));
    subplot(1,2,2);
    imshow(im_normal_obj.*uint8(double(mask_curr)));
    
    figure(h)
    imshow(mask_curr);
    hold on;
    plotBoxes(h,bbox,'-r',2);
    hold off;
    title(num2str([group_id_curr(i) cat_no_aft_curr(i)]));
    pause;
    %%%%%%%%%%
end

record_detections(mod_no).id_name=id_name;
record_detections(mod_no).match_name=match_name;
record_detections(mod_no).group_id=group_id_curr;
record_detections(mod_no).cat_no_aft=cat_no_aft_curr;
record_detections(mod_no).boxes=boxes;
record_detections(mod_no).masks=masks;
record_detections(mod_no).bin_visibility=bin_visibility;








