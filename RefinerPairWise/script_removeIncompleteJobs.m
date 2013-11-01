ccc

dir_parent='/home/maheenr/results_temp_09_13';
folder='swapAllCombos_unique_10_auto';

load(fullfile(dir_parent,[folder '_html'],'errorLog.mat'),'errorLog');

im_names={errorLog(:).name};

matlabpool open
parfor i=1:numel(im_names)
    rmdir(fullfile(dir_parent,folder,im_names{i}),'s');
end
matlabpool close

