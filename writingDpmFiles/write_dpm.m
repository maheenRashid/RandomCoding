function write_dpm(fname,cell2print)
type=cell2mat(cell2print(1,:));
pts_all=cell2print(2,:);

fid=fopen(fname,'w');
        fprintf(fid,'%s\n',num2str(numel(type)));

for pt_no=1:numel(pts_all)
    pts=pts_all{pt_no};
        fprintf(fid,'%s\n',num2str(type(pt_no)));
for i=1:4
    for j=1:2
        fprintf(fid,'%s\n',num2str(pts(j,i)));
    end
end
        fprintf(fid,'%s\n','C');

end
fclose(fid);
end