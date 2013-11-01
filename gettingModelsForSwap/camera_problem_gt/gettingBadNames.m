ccc
dir_parent='/lustre/maheenr/results_temp_09_13';
folder='gt_raw';
out_dir=fullfile(dir_parent,[folder '_html']);

names=dir(fullfile(dir_parent,folder));
names=names(3:end);


bad_names=cell(1,0);
for i=1:numel(names)
    id_curr=names(i).name;
    fid=fopen(fullfile(dir_parent,folder,id_curr,'scores_and_offsets.txt'));
    data=textscan(fid,'%s','delimiter','\n');
    fclose(fid);
    data=data{1};
    if numel(data)<=3
        bad_names=[bad_names id_curr];
    end
    
end

save(fullfile(out_dir,'bad_names.mat'),'bad_names');