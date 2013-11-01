ccc
dir_parent='/lustre/maheenr/results_temp_09_13';
folders={'/home/maheenr/results_temp_09_13/swapModelInBox_newLabels_bestSortedByDPMScore_auto'
    '/home/maheenr/results_temp_09_13/swapModelInBox_newLabels_bestSortedByDPMScore_gt'
    '/home/maheenr/results_temp_09_13/swapModelInBox_newLabels_bestSortedByPredScore_auto'
    '/home/maheenr/results_temp_09_13/swapModelInBox_newLabels_bestSortedByPredScore_gt'};

dir_gt='gt_raw_correct';


for folder_no=1:numel(folders)
    folder=folders{folder_no}
    out_dir=[folder '_html'];
    
    if ~exist(out_dir)
        mkdir(out_dir);
    end
%     disp('getting best scores')
%     getBestScores;
%     
%     load (fullfile(out_dir,'record_bestMatch.mat'));
%     names_and_scores=createScoreMatModel(record_bestMatch);
%     save(fullfile(out_dir,'names_and_scores.mat'),'names_and_scores');
%     
%     disp('writing html')
%     org_folder=pwd();
%     copyfile('writingHTMLs_swapModelInBox.m',fullfile(out_dir,'writingHTMLs.m'));
%     cd (out_dir);
    folder=regexpi(folder,'/','split');
    folder=folder{end};
%     writingHTMLs;
%     cd (org_folder);
    
    dir_parent='/lustre/maheenr/results_temp_09_13';
    
    disp('getting file names')
    gettingRelevantFiles;
    disp('getting detections data')
    getDetBBAndMask;
    
    err_names={errorLog(1:end).name};
    err_names=find(~cellfun(@isempty,err_names))
    disp('getting accuracy_gt')
    getAccuracy_gt
    disp('getting accuracy_dpm')
    getAccuracy_dpm
end
