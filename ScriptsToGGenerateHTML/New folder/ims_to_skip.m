load('errorLog.mat');
% errorLog={'dummy','dummy1','dummy2'};
folder='/lustre/maheenr/results_temp_09_13/swapObjectsInBox_allOffsets_sizeComparison_rerun';
dir_all=dir(folder);
dir_all=dir_all(3:end);

ims_to_skip=cell(1,0);
for dir_no=1:numel(dir_all)
    im_curr=dir_all(dir_no).name;
    if sum(strcmp(im_curr,errorLog))==0
        ims_to_skip=[ims_to_skip im_curr];
    end
end

save('ims_to_skip.mat');