ccc

dir_parent='/home/maheenr/results_temp_09_13';
folder='swapAllCombos_unique_10_auto';

im_names=dir(fullfile(dir_parent,folder));
im_names=im_names(3:end);
im_names={im_names(:).name};
temp=cell(1,numel(im_names));
errorLog=struct('name',temp);

matlabpool open
parfor i=1:numel(im_names)
    if ~exist(fullfile(dir_parent,folder,im_names{i},'lists_and_scores.txt'),'file')
        errorLog(i).name=im_names{i};
    end
end
matlabpool close

idx=cellfun(@isempty,{errorLog(:).name});
errorLog(idx)=[];

save(fullfile(dir_parent,[folder '_html'],'errorLog.mat'),'errorLog');