ccc

pre='/lustre/maheenr/results_temp_09_13/'
folders={'swapObjectsInBox_allOffsets_sizeComparison_bestSortedByDPMScore_gt',...
    'swapObjectsInBox_allOffsets_sizeComparison_bestSortedByDPMScore_auto',...
    'swapObjectsInBox_allOffsets_sizeComparison_bestSortedByPredScore_gt',...
    'swapObjectsInBox_allOffsets_sizeComparison_bestSortedByPredScore_auto'};

 gt_results='/lustre/maheenr/results_temp_09_13/swapObjectsInBox_allOffsets_sizeComparison_bugFixed_gt_boxesKept';
 auto_results='/lustre/maheenr/results_temp_09_13/swapObjectsInBox_allOffsets_sizeComparison_bugFixed_boxesKept';
 
 
 for i=1:numel(folders)
     folder=[pre folders{i}];
     createScoreMatAndWriteHTML(folder)
 end
 script_test_gt;
 scriptOnGroundBoxes_multipleFolders;
analyzingValidDections_multipleFolders;

getKeptBin_multipleFolders;