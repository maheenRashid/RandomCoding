
out_dirs=cellfun(@(y) [pre y '_html'],folders,'UniformOutput',0)

for out_dir_no=1:numel(out_dirs)

out_dir=out_dirs{out_dir_no};
if strfind(out_dir,'gt')
    dir_results=gt_results;
else
    dir_results=auto_results;
end


if ~exist(out_dir,'dir')
    mkdir(out_dir)
end

im_list=getNamesFromDir(dir_results);

for i=1:numel(im_list)

fid=fopen(fullfile(dir_results,im_list{i},'scores_and_offsets.txt'));
data=textscan(fid,'%s','delimiter','\n');
fclose(fid);
data=data{1};
data=data(2:end);

data=cellfun(@str2double,data);
record_on_ground{1,i}=im_list{i};
record_on_ground{2,i}=data;
end

save(fullfile(out_dir,'boxes_on_ground.mat'),'record_on_ground');


end