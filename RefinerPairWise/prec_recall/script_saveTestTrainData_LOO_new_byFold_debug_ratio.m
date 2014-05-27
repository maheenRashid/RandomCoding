%difference with _LOO.m is that this includes whitening.
%also path names are in meta script.


%create directory for output
if ~exist(out_dir_old,'dir')
    mkdir(out_dir_old);
end


models=dir(fullfile(dir_feature_vec,'*.mat'));
models={models(:).name};
models=cellfun(@(x) x(1:end-4),models,'UniformOutput',0);


%load folds
load (fullfile('..','gt_list_and_fold.mat'),'gt_list','gt_folds');

%for ease, remove names not in folder
bin_removal=zeros(1,numel(gt_list));
for i=1:numel(gt_list)
    if sum(strcmp(gt_list{i},models))==0
        bin_removal(i)=1;
    end
end
bin_removal=bin_removal>0;
gt_list(bin_removal)=[];
gt_folds(bin_removal)=[];


%create sets of names based on folds
fold_nos=unique(gt_folds);
names_foldwise=cell(1,numel(fold_nos));
for i=1:numel(fold_nos)
    names_foldwise{i}=gt_list(gt_folds==fold_nos(i));
end


for fold_no=1:numel(names_foldwise)
    models_curr=names_foldwise{fold_no};

    out_mutex=fullfile(out_dir_old,[num2str(fold_no) '_detsDebug']);

    if ~exist(out_mutex,'dir')
        mkdir(out_mutex);
    else
        continue;
    end
    


    tic()
    [dets_all,error_files]=getResponse_noWeight...
        (dir_feature_vec,models_curr);
    toc()
         response_dpm=cellfun(@(x) x{1},dets_all,'UniformOutput',0);
      response_dpm=cellfun(@(x) x(:,2),response_dpm,'UniformOutput',0);

    save(fullfile(out_mutex,[num2str(fold_no) '.mat']));

end

