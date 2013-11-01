ccc

dir_parent='/lustre/maheenr/results_temp_09_13';

folders={'swapObjectsInBox_allOffsets_sizeComparison_bugFixed_gt_refPW','swapObjectsInBox_allOffsets_sizeComparison_bugFixed_refPW'};



for folder_no=1:numel(folders)
    folder=folders{folder_no};
    load(fullfile(dir_parent,folder,'record_box_info_all.mat'),'record_box_info_all');
    n=10;
    temp=cell(1,numel(record_box_info_all));
    record_box_info_all_copy=struct('id',temp,'box_ids',temp,'swap_info',temp,'pred_scores',temp,'gt_scores',temp);
    matlabpool open;
    parfor i=1:numel(record_box_info_all)
        
        record_box_info_all_copy(i)=getTopNFromFileStruct_UniqueScores(n,record_box_info_all(i));
        
    end
    matlabpool close;
    record_box_info_all=record_box_info_all_copy;
    save(fullfile(dir_parent,folder,['record_box_info_all_unique_top_' num2str(n) '.mat']),'record_box_info_all');
    
    
    
end
