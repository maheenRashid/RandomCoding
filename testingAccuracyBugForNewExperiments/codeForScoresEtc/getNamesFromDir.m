function [ fileNames ] = getNamesFromDir( dirName )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

dir_struct=dir(dirName);
dir_struct=dir_struct(3:end);
fileNames=cell(1,numel(dir_struct));
for i=1:numel(dir_struct)
    fileNames{i}=dir_struct(i).name;
end
end

