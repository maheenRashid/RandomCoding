function [ matches,idx ] = matchString( names,strToMatch )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
bin=strfind(names,strToMatch);
idx=cellfun(@isempty,bin);
idx=~idx;
matches=names(idx);
idx=find(idx);

end

