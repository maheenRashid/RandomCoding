ccc
folder='/lustre/maheenr/results_temp_09_13/swapObjectsInBox_allOffsets_sizeComparison_bestSortedByPredScore_auto';
out_folder=createScoreMat_function(folder);
copyfile('writingHTMLs.m',fullfile(out_folder,'writingHTMLs.m'));
cd (out_folder);
folder='swapObjectsInBox_allOffsets_sizeComparison_bestSortedByPredScore_auto'
writingHTMLs;
