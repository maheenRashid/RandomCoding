ccc




dir_parent='/lustre/maheenr/results_temp_09_13';
dir_gt='gt_raw_correct';

out_dir=fullfile(dir_parent,[dir_gt '_html']);
if ~exist(out_dir,'dir')
    mkdir(out_dir)
end



dir_models=dir(fullfile(dir_parent,dir_gt));
dir_models=dir_models(3:end);


getGoodNames;
getBadNames;
integrateBadNames;
