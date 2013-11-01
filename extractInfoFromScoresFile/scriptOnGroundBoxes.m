ccc
dir_results='/lustre/maheenr/results_temp_09_13/swapObjectsInBox_allOffsets_sizeComparison_bugFixed_gt_boxesKept';
out_dir='/lustre/maheenr/results_temp_09_13/swapObjectsInBox_allOffsets_sizeComparison_bugFixed_gt_html';
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


