% ccc

fid=fopen('files_model_swap.txt');
files=textscan(fid,'%s','delimiter','\n');
files=files{1};
files=cellfun(@(x) strrep(x,'%23','#'),files,'UniformOutput',0);
files=cellfun(@(x) strrep(x,'http://warp.hpc1.cs.cmu.edu:8000','/lustre/maheenr'),files,'UniformOutput',0);
idx_last_slash=cellfun(@(x) strfind(x,'/'),files,'UniformOutput',0);
files=cellfun(@(x,y) x(1:y(end)),files,idx_last_slash,'UniformOutput',0);

out_dir='models_swap';
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end


for file_no=1:numel(files)
    file_no
    file_curr=files{file_no};
    folder_name=regexpi(file_curr,'/','split');
    folder_name=folder_name{end-2};
    copyfile([file_curr '*'],fullfile(out_dir,folder_name));
end
    