function bin=getCatIntersection(dir,model_matches,cat)

cat_cell=cell(1,numel(model_matches));
for i=1:numel(model_matches)
    fid=fopen(fullfile(dir,[model_matches{i} '.txt']));
    if fid==-1
        continue
    end
    data=textscan(fid,'%s','delimiter','\n');
    fclose(fid);
    data=data{1};
    data=cellfun(@str2num,data);
    cat_cell{i}=data;
end

bin=cellfun(@(x) sum(x==cat),cat_cell);
bin=bin>0;


end