
dir_models=getNamesFromDir(folder);
record_bestMatch_meta=struct();

matlabpool open
parfor model_no=1:numel(dir_models)
    dir_boxes=getNamesFromDir(fullfile(folder,dir_models{model_no}));
    record_bestMatch=struct();
    for box_no=1:numel(dir_boxes)
        %         idx_no=model_no+box_no-1;
        idx_no=box_no;
        
        dir_matches=getNamesFromDir(fullfile(folder,dir_models{model_no},dir_boxes{box_no}));
        best_score=-Inf;
        for match_no=1:numel(dir_matches)
            
            fid= fopen(fullfile(folder,dir_models{model_no},dir_boxes{box_no},dir_matches{match_no},'scores_and_offsets.txt'));
            data=textscan(fid,'%s','delimiter','\n');
            data=data{1};
            fclose(fid);
            try
                [scores_bef,scores_after_dpm,scores_aft]=getScoresModelSwap(data);
            catch error
                continue;
            end
            if scores_aft(1)>best_score
                record_bestMatch(idx_no).name=dir_models{model_no};
                record_bestMatch(idx_no).box_no=str2num(dir_boxes{box_no});
                record_bestMatch(idx_no).matchId=dir_matches{match_no};
                record_bestMatch(idx_no).score_before=scores_bef;
                record_bestMatch(idx_no).score_after_DPM=scores_after_dpm;
                record_bestMatch(idx_no).score_after=scores_aft;
                best_score=scores_aft(1);
            end
        end
    end
    record_bestMatch_meta(model_no).temp=record_bestMatch;
end
matlabpool close

record_bestMatch_final=struct();
for i=1:numel(record_bestMatch_meta)
    record_bestMatch_curr=record_bestMatch_meta(i).temp;
    if isempty(fieldnames(record_bestMatch_curr))
        continue;
    end
    
    if isempty(fieldnames(record_bestMatch_final))
        record_bestMatch_final=record_bestMatch_curr;
    else
        record_bestMatch_final=[record_bestMatch_final record_bestMatch_curr];
    end
    
end

record_bestMatch=record_bestMatch_final;

save(fullfile(out_dir,'record_bestMatch.mat'),'record_bestMatch');
