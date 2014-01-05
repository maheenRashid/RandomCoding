
dir_dpm='/lustre/maheenr/writeDPMFiles/im_dpm_greater_-1';
parent_dir='/lustre/maheenr/results_temp_09_13';

folders=dir(fullfile(pwd(),'*.txt'));
folders={folders(:).name};

folders=cellfun(@(x) x(1:end-4),folders,'UniformOutput',0);
folders={'swapObjectsInBox_allOffsets_sizeComparison_bestSortedByDPMScore_auto'};

files_to_copy={'final_with_cube_*.png','repFinal_*.png',...
    'each_rep_-01_-01_-01_-01_-01_overlay.png'};


files_to_copy={'*.png'};



for folder_no=1:numel(folders)
folder=folders{folder_no};
out_dir=folder;
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end

fid=fopen([folder '.txt']);
models=textscan(fid,'%s','delimiter','\n');
models=models{1};
for model_no=1:numel(models)
    model_curr=models{model_no};
    
    strs=cell(1,0);
    for file_no=1:numel(files_to_copy)
        path_to_file=fullfile(parent_dir,folder,model_curr,'renderings');
        temp=dir(fullfile(path_to_file,files_to_copy{file_no}));
        temp={temp(:).name};
        temp=cellfun(@(x) fullfile(path_to_file,x),temp,'UniformOutput',0);
        strs=[strs,temp];
    end
    model_curr_justname=regexpi(model_curr,'#','split');
    model_curr_justname=model_curr_justname{end};
    dpm_file=fullfile(dir_dpm,[model_curr_justname '.jpg']);
    strs=[strs dpm_file];
    
    out_dir_curr=fullfile(out_dir,model_curr);
    if ~exist(out_dir_curr,'dir')
        mkdir(out_dir_curr);
    end
    file_name_org=cellfun(@(x) x{end},regexpi(strs,'[\\/]','split'),'UniformOutput',0);
    for file_no=1:numel(strs)
        dest_file_name=fullfile(out_dir_curr,file_name_org{file_no});
        copyfile(strs{file_no},dest_file_name);
    end
    
    
end


end