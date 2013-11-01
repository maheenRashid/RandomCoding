function [names_and_scores]=createScoreMatModel( record_bestMatch )
scores_after={record_bestMatch(1:end).score_after};
idx=~cellfun(@isempty,scores_after);
scores_after=scores_after(idx);
scores_before={record_bestMatch(idx).score_before};
names={record_bestMatch(idx).name};
matches={record_bestMatch(idx).matchId};

scores=cellfun(@(x,y) [x;y],scores_before,scores_after,'UniformOutput',0);
str_bef='final_with_cube_';
str_aft='final_model_';
temp=cell(1,numel(scores_after));
[temp{:}]=deal(str_bef);
temp2=cell(1,numel(scores_after));
[temp2{:}]=deal(str_aft);

names_and_scores=[names;matches;scores;temp;temp2];
end



