ccc

out_dir='code_RefinerPairWise_smooth_pipeline';
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end

files_to_copy={'script_pruneAllBoxesInfo_Unique.m';
    'getTopNFromFileStruct_UniqueScores.m';
    'script_writeTextFiles.m';
    'writeTopNFileFromStruct.m';
    'script_writingListsFilesAfterReadingOverlap.m';
    'getAllLists.m';
    'getValidLists.m';
    'script_parseListFiles.m';
    'parsave.m';
    'script_creatingDPMBinPerList.m';
    'getBinFromList.m';
    'getBinMatchWithObjMap.m';
    'record_dpm.mat'};

% mat_dir='D:\ResearchCMU\git\Image-Modeling\MATLAB_for_visu';
% files_to_copy={'swapObjectsInBox_allOffsets_sizeComparison_bugFixed_gt.mat',...
%     'swapObjectsInBox_allOffsets_sizeComparison_bugFixed.mat'};     

for i=1:numel(files_to_copy)
    copyfile(fullfile(mat_dir,files_to_copy{i}),fullfile(out_dir,files_to_copy{i}));
end


