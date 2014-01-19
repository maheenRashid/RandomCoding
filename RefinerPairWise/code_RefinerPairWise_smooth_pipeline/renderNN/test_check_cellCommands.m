ccc
load swapAllCombos_unique_3_gt_nn_neighbours_0.01.mat

cellCommands=cellCommands(:);
temp=cellCommands{1};

temp=regexpi(temp,' ','split');
fid=fopen('temp.txt','w');
for i=1:numel(temp)
    fprintf(fid,'%s\n',temp{i});
end
fclose(fid);