function [data]=readInBestSwapFile(filename)
    fid=fopen(filename);
    data=textscan(fid,'%s','delimiter','\n');
    data=data{1};
    data=data(2:end);
    data=reshape(data,6,[]);
    data=data(1:5,:);
    data=cellfun(@str2num,data);
    data=data';
    
end