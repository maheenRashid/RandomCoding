ccc

cam_dir_meta='/lustre/maheenr/cube_per_cam_regenerate';
gt_dir='room3D_gt';

list_txt='list_files_2';
list_score='lists_scores_2';

models=dir(fullfile(cam_dir_meta,gt_dir,list_score));
models={models(3:end).name};
complete=zeros(size(models));
matlabpool open local 4
parfor model_no=1:numel(models)
    fprintf('model_no %d\n',model_no);
    model_curr=models{model_no};
    file_scores=fullfile(cam_dir_meta,gt_dir,list_score,model_curr,'scores_and_offsets.txt');
    fid=fopen(file_scores);
    data=textscan(fid,'%s','delimiter','\n');
    fclose(fid);
    data=data{1};
    count=strfind(data,'After list');
    count=~cellfun(@isempty,count);
    count=sum(count);
    
    file_lists=fullfile(cam_dir_meta,gt_dir,list_txt,[model_curr '.txt']);
    fid=fopen(file_lists);
    data=textscan(fid,'%s','delimiter','\n');
    fclose(fid);
    data=data{1};
    total=str2double(data{1});
    
    complete(model_no)=(total*2==count);
end
matlabpool close;

models_exclude=models(complete==0);
numel(models_exclude)

cam_dir_meta='/lustre/maheenr/cube_per_cam_regenerate';
gt_dir='room3D_gt';

swap_dirs={'best_swap_txt_test_1','best_swap_txt_2','best_swap_txt_test_3'};

models=dir(fullfile(cam_dir_meta,gt_dir,swap_dirs{1},'*.txt'));
models={models(:).name};

swap_infos=cell(numel(models),numel(swap_dirs));

for model_no=1:numel(models)
    for dir_no=1:numel(swap_dirs)
        fname=fullfile(cam_dir_meta,gt_dir,swap_dirs{dir_no},models{model_no});
        swap_infos{model_no,dir_no}=readInBestSwapFile(fname);
    end
end

bin_info=cell(numel(models),2);
for model_no=1:numel(models)
    for dir_no=1:2
        bin_info{model_no,dir_no}=ismember(swap_infos{model_no,3},swap_infos{model_no,dir_no},'rows');
    end
end

save(fullfile(cam_dir_meta,gt_dir,'best_swap_overlap.mat'),'bin_info',...
    'swap_infos','swap_dirs','models','models_exclude');


