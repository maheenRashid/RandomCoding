ccc
dir_parent='/lustre/maheenr/results_temp_09_13';
folders={'/home/maheenr/results_temp_09_13/swapModelInBox_bestSortedByDPMScore_auto'
    '/home/maheenr/results_temp_09_13/swapModelInBox_bestSortedByDPMScore_gt'
    '/home/maheenr/results_temp_09_13/swapModelInBox_bestSortedByPredScore_auto'
    '/home/maheenr/results_temp_09_13/swapModelInBox_bestSortedByPredScore_gt'};

for folder_no=1:numel(folders)
    folder=folders{folder_no};
        folder=regexpi(folder,'/','split');
    folder=folder{end};

    load(fullfile(dir_parent,[folder '_html'],'record_detections.mat'),'record_detections');

rec_fields=fieldnames(record_detections);
if numel(rec_fields)>7
    rec_fields(8:end)
    record_detections=rmfield(record_detections,rec_fields(8:end));
    fieldnames(record_detections)

end

    save(fullfile(dir_parent,[folder '_html'],'record_detections.mat'),'record_detections');


end