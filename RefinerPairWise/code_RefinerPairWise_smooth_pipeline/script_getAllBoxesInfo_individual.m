matlabpool open;
parfor i=1:numel(names)
    fprintf('%d\n',i);
%     try
        fid=fopen(fullfile(in_dir,names{i},'scores_and_offsets.txt'));
        data=textscan(fid,'%s','delimiter','\n');
        fclose(fid);
        data=data{1};
        [box_ids,swap_info,pred_scores,gt_scores]=getSwapAndScoreInfoAll(data);
        record_box_info_all=struct();
        record_box_info_all.id=names{i};
        record_box_info_all.box_ids=box_ids;
        record_box_info_all.swap_info=swap_info;
        record_box_info_all.pred_scores=pred_scores;
        record_box_info_all.gt_scores=gt_scores;
        out_file_name=fullfile(out_dir,[names{i} '.mat']);
        parsave_name(out_file_name,record_box_info_all,'record_box_info_all');
        
        
        
        
%     catch err
%         disp('error!');
%         names{i}
%     end
    
end
matlabpool close;



