function [ mapping] = getMapping( dpm_str )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

   dpm_rec={'bed'    'chair'    'sidetable'    'sofa'    'table';...
       8,10,12,9,11};

    mapping=zeros(1,numel(dpm_str));
    for str_no=1:numel(dpm_str)
        a=strcmp(dpm_str{str_no},dpm_rec(1,:));
        mapping(str_no)=dpm_rec{2,a};
    end


end

