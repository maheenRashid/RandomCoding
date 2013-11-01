ccc

fid=fopen('lists_and_scores_overlap.txt');
data=textscan(fid,'%s','delimiter','\n');
data=data{1};
fclose(fid);

idx=find(strcmp('floor_overlap',data));
overlap=data(idx+1:end);
overlap=cell2mat(cellfun(@(x) str2num(x),overlap,'UniformOutput',0));



thresh=0.01;
overlap_bin=overlap<thresh;
overlap_bin=sparse(overlap_bin);

filename='test_lists.txt';

clearvars -except overlap_bin filename

lists=getAllLists(overlap_bin);
lists=cellfun(@(x) x-1,lists,'UniformOutput',0);

fid=fopen(filename,'w');
fprintf(fid,'%d\n',numel(lists));
fprintf(fid,'%s\n','C');
for i=1:numel(lists)
    fprintf(fid,'%d\n',numel(lists{i}));
    for j=1:numel(lists{i})
        fprintf(fid,'%d\n',lists{i}(j));
    end
    fprintf(fid,'%s\n','C');
end


