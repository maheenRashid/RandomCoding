function [ gt_scores ] = getGTScoresFromStr( temp )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
gt_score_str='GT_SCORE_all_px';

    temp=regexpi(temp,' ','split');
idx_gt=strcmp(gt_score_str,temp);
idx_gt=find(idx_gt);
gt_scores=cellfun(@str2double,temp(idx_gt+1:2:end));


end

