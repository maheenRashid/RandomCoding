ccc
dir_parent='/home/maheenr/results_temp_09_13';
folder='swapAllCombos_unique_10_auto_writeAndScoreLists';

out_dir=fullfile(dir_parent,[folder '_html']);
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end

models=dir(fullfile(dir_parent,folder));
models=models(3:end);
models={models(:).name};

still_running=cell(1,0);

for i=1:numel(models)

    check=dir(fullfile(dir_parent,folder,models{i},'renderings','list*.png'));
    check={check(:).name};
    if isempty(check)
        still_running=[still_running models{i}];
    end

end

save(fullfile(out_dir,'still_running.mat'),'still_running');
