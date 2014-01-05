ccc

dir_parent='/home/maheenr/results_temp_09_13';
folder='swapAllCombos_unique_10_gt_writeAndScoreLists';

dir_dpm_bin=fullfile(dir_parent,[folder '_html'],'record_lists_dpm_bin');

models=dir(fullfile(dir_dpm_bin,'*.mat'));
models={models(:).name};
models=cellfun(@(x) x(1:end-4),models,'UniformOutput',0);

out_dir=fullfile(dir_parent,[folder '_html'],'svm_trial_temp');
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end



matlabpool open
parfor model_no=1:100
    model_no
    temp=load(fullfile(dir_dpm_bin,[models{model_no} '.mat']));
    record_lists=temp.record_lists;
    pred_score=cell2mat(record_lists.scores');
    dpm_score=record_lists.dpm_scores;
    dpm_score=dpm_score+1;
    dpm_scores=cellfun(@(x) dpm_score.*x(:,3),record_lists.accuracy,'UniformOutput',0);
    svm_vecs=cellfun(@(x,y) [x;y],record_lists.scores,dpm_scores','UniformOutput',0);
    
    record_lists.svm_vecs=svm_vecs;
    out_file_name=fullfile(out_dir,[models{model_no} '.mat']);
    parsave(out_file_name,record_lists);
end
matlabpool close
