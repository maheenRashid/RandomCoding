load(fullfile(dir_parent,[folder '_html'],'names_and_scores.mat'));


relevant_files=cell(5,size(names_and_scores,2));
[relevant_files{1,:}]=deal('each_rep_-01_-01_-01_-01_-01_normal.png');
[relevant_files{3,:}]=deal('raw_cat_mask.png');
[relevant_files{4,:}]=deal('raw_object_mask.png');

for i=1:size(names_and_scores,2)
    fullpath=fullfile(dir_parent,folder,names_and_scores{1,i},names_and_scores{2,i},'renderings');
    final_rep=dir(fullfile(fullpath,'final_rep*normal.png'));
    relevant_files{2,i}=final_rep(1).name;
    relevant_files{end,i}=fullpath;
end

save(fullfile(dir_parent,[folder '_html'],'relevant_files.mat'),'relevant_files');