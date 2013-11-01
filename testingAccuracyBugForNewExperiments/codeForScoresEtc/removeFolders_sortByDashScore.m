ccc

pre='/home/maheenr/results_temp_09_13/';
folders={'swapObjectsInBox_allOffsets_sizeComparison_bestSortedByDPMScore_gt',...
    'swapObjectsInBox_allOffsets_sizeComparison_bestSortedByDPMScore_auto',...
    'swapObjectsInBox_allOffsets_sizeComparison_bestSortedByPredScore_gt',...
    'swapObjectsInBox_allOffsets_sizeComparison_bestSortedByPredScore_auto'};
matlabpool open
    
parfor folder_no=1:numel(folders)
    curr_folder=[pre folders{folder_no}]
    rmdir(curr_folder,'s');
    curr_folder=[pre folders{folder_no} '_html']
    rmdir(curr_folder,'s');

end
matlabpool close;




% pre='/home/maheenr/results_temp_09_13/';
% folder={'swapObjectsInBox_allOffsets_sizeComparison_bestSortedByPredScore_auto'...
%     ,'swapObjectsInBox_allOffsets_sizeComparison_bestSortedByPredScore_gt'};
% for i=1:numel(folder)
%     folder{i}=[pre folder{i}];
% end
%     
% for folder_no=1:numel(folder)
%     load(fullfile(folder{folder_no},'errorLog.mat'));
%     matlabpool open
%     parfor i=1:numel(errorLog)
%         rmdir(errorLog{i},'s');
%     end
%     matlabpool close;
% 
% end
% return