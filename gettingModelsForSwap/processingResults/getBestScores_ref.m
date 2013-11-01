
dir_models=getNamesFromDir(folder);
record_bestMatch=struct();

matlabpool open
parfor model_no=1:numel(dir_models)
    record_bestMatch(model_no).name=dir_models{model_no};
    dir_matches=getNamesFromDir(fullfile(folder,dir_models{model_no}));
    
    best_score=-Inf;
    
    for match_no=1:numel(dir_matches)
	
        fid= fopen(fullfile(folder,dir_models{model_no},dir_matches{match_no},'scores_and_offsets.txt'));
        data=textscan(fid,'%s','delimiter','\n');
        data=data{1};
        fclose(fid);
        try
            [scores_bef,scores_after_dpm,scores_aft]=getScoresModelSwap_ref(data);
        catch error
            continue;
        end
        if scores_aft(1)>best_score
            record_bestMatch(model_no).matchId=dir_matches{match_no};
            record_bestMatch(model_no).score_before=scores_bef;
            record_bestMatch(model_no).score_after_DPM=scores_after_dpm;
            record_bestMatch(model_no).score_after=scores_aft;
            
            ref_file=dir(fullfile(folder,dir_models{model_no},dir_matches{match_no},'renderings','final_rep_with_ref*'));
            ref_file=ref_file(1).name;
            idx_end=strfind(ref_file,'_');
            idx_end=idx_end(end);
            ref_file=ref_file(1:idx_end);  
            record_bestMatch(model_no).ref_file=ref_file;
%             ref_file
%             keyboard;
            best_score=scores_aft(1);
        end
    end
    

end
matlabpool close

save(fullfile(out_dir,'record_bestMatch.mat'),'record_bestMatch');
