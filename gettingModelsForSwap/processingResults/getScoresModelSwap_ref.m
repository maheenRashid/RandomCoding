function [scores_bef,scores_after_dpm,scores_aft]=getScoresModelSwap_ref(data)

    scores_bef=getScoresMat(data(2:3));
    
    idx=~cellfun(@isempty,strfind(data,'After final'));
    scores_after_dpm=getScoresMat(data(idx));
    
    idx=~cellfun(@isempty,strfind(data,'final_rep_with_ref'));
    scores_aft=getScoresMat(data(idx));
    
end
