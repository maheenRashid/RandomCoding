
 pre='/home/maheenr/results_temp_09_13/';
 folder={'swapObjectsInBox_allOffsets_sizeComparison_bestSortedByPredScore_auto'...
     ,'swapObjectsInBox_allOffsets_sizeComparison_bestSortedByPredScore_gt'};
 for i=1:numel(folder)
     folder{i}=[pre folder{i}];
 end
     
 for folder_no=1:numel(folder)
     load(fullfile(folder{folder_no},'errorLog.mat'));
     matlabpool open
     parfor i=1:numel(errorLog)
         rmdir(errorLog{i},'s');
     end
     matlabpool close;
 
 end
 return

% load('errorLog.mat');
% % errorLog={'dummy','dummy1','dummy2'};
% folder='/lustre/maheenr/results_temp_09_13/swapObjectsInBox_allOffsets_sizeComparison_rerun';
% matlabpool close force local
% matlabpool open
% parfor i=1:numel(errorLog)
%     rmdir(fullfile(folder,errorLog{i}),'s');
% end
% matlabpool close;
% 
% return
pre='/home/maheenr/results_temp_09_13/';
folder={'swapObjectsInBox_allOffsets_sizeComparison_bestSortedByPredScore_auto'...
    ,'swapObjectsInBox_allOffsets_sizeComparison_bestSortedByPredScore_gt'};
for i=1:numel(folder)
    folder{i}=[pre folder{i}];
end


for folder_no=1:numel(folder)
dir_all=dir(folder{folder_no});
dir_all=dir_all(3:end);
errorLog=cell(1,0);
for dir_no=1:numel(dir_all)
    final_file_name=fullfile(folder{folder_no},dir_all(dir_no).name,'renderings','final_with_cube_normal.png');
    if ~exist(final_file_name,'file')
        errorLog=[errorLog fullfile(folder{folder_no},dir_all(dir_no).name)];
    end
end

save(fullfile(folder{folder_no},'errorLog.mat'));
end
