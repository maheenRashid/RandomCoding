ccc
fid=fopen('lists_file.txt');
data_lw=textscan(fid,'%s','delimiter','\n');
data_lw=data_lw{1};
fclose(fid);
fid=fopen('lists_printed.txt');
data_lp=textscan(fid,'%s','delimiter','\n');
data_lp=data_lp{1};
fclose(fid);

idx=find(~cellfun(@isempty,cellfun(@(x) strfind(x,'C'),data_lw,'UniformOutput',0)));
idx=idx(1:21);

lists_mat_lp=cellfun(@(x) str2num(x),data_lp,'UniformOutput',0);

n_lists=20;

lists_mat_lw=cell(n_lists,1);

for i=1:n_lists;
    str_curr=data_lw(idx(i)+2:idx(i+1)-1);
    str_curr=str_curr';
    str_curr=sprintf('%s ', str_curr{:});
    lists_mat_lw{i}=str2num(str_curr);
end


isEqual_lists(lists_mat_lw,lists_mat_lp);



