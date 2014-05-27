function [vec]=getVecFromFile(filename)
    fid=fopen(filename);
    vec=textscan(fid,'%s','delimiter','\n');
    fclose(fid);
    
    vec=vec{1};
    vec=cellfun(@str2num,vec);
end