ccc

dir_results='/lustre/maheenr/results_temp_09_13/swapObjectsInBox_allOffsets_sizeComparison_bugFixed_gt';
out_dir='/lustre/maheenr/results_temp_09_13/swapObjectsInBox_allOffsets_sizeComparison_bugFixed_gt_html';
if ~exist(out_dir)
    mkdir(out_dir);
end
names=getNamesFromDir(dir_results);

record_cell=cell(6,numel(names));
errorLog=cell(1,0);

% load(fullfile(out_dir,'boxes_we_kept.mat'),'errorLog','record_cell');
for i=1:numel(names)
    names{i}
    try
        fid=fopen(fullfile(dir_results,names{i},'scores_and_offsets.txt'));
        data=textscan(fid,'%s','delimiter','\n');
        fclose(fid);
        data=data{1};
        
        pred_score_org=data{2};
        pred_score_org=regexpi(pred_score_org,' ','split');
        pred_score_org=str2double(pred_score_org{end});
        
        data=data(4:end);
        [box_nos,keep_bool,score_infos,swap_infos]=getBestSwapPerBoxInfo(data,pred_score_org);
        [swap_infos_cmpAll,score_infos_cmpAll]=getKeepBoxIdsAndScores(data);
        
        record_cell{1,i}=swap_infos;
        record_cell{2,i}=keep_bool;
        record_cell{3,i}=score_infos;
        record_cell{4,i}=swap_infos_cmpAll;
        record_cell{5,i}=score_infos_cmpAll;
        record_cell{6,i}=names{i};
    catch err
        disp('error!');
        errorLog=[errorLog names{i}];
    end
    save(fullfile(out_dir,'boxes_we_kept.mat'),'errorLog','record_cell');
end

save(fullfile(out_dir,'boxes_we_kept.mat'),'errorLog','record_cell');




% data=data(4:end);
% [box_ids,keep_scores]=getKeepBoxIdsAndScores(data)
