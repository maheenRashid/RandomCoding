function [scores_bef,scores_after_dpm,scores_aft]=getScoresModelSwap(data)

    scores_bef=getScoresMat(data(2:3));
    
    idx=~cellfun(@isempty,strfind(data,'After final'));
    scores_after_dpm=getScoresMat(data(idx));
    
    idx=~cellfun(@isempty,strfind(data,'final_rep'));
    scores_aft=getScoresMat(data(idx));
    
end
