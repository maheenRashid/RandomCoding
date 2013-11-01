function [ names ] = getNamesFromStruct(the_struct )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
names=cell(1,numel(the_struct));
for i=1:numel(the_struct)
    names{i}=the_struct(i).name;
end

end

