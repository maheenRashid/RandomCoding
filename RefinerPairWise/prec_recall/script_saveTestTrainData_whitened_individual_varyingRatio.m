%difference with _LOO.m is that this includes whitening.
%also path names are in meta script.

%create directory for output
if ~exist(out_dir,'dir')
    mkdir(out_dir);
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


%iterate over each set
for fold_no=1:numel(names_foldwise)
    fprintf('fold no %d\n',fold_no);
    out_mutex=fullfile(out_dir_old,[num2str(fold_no) '_detsDebug']);
    
    %check existence
    to_load_file=fullfile(out_mutex,[num2str(fold_no) '.mat']);
    
    if ~exist(to_load_file,'file')
        continue;
    end
    load(to_load_file,'response_dpm','dets_all','models_curr');
    
%     matlabpool open
%     par
    for test_idx=1:numel(models_curr)
        fprintf('test_idx %d\n',test_idx);
        
        out_mutex=fullfile(out_dir,[models_curr{test_idx} '_dets']);
        if ~exist(out_mutex,'dir')
            mkdir(out_mutex);
        else
            continue;
        end
        
        train_idx=1:numel(models_curr);
        train_idx(test_idx)=[];
        
        in_file_name=fullfile(out_dir_old,[models_curr{test_idx} '.mat']);
        if exist(in_file_name,'file')
            record_lists=load(in_file_name);
        else
            continue;
        end
        record_lists=record_lists.record_lists;
        
        a=response_dpm;
        a(test_idx)=[];
        a=cellfun(@(x) sum(x)/numel(x),a);
        a(isnan(a))=1;
        ratio=mean(a);
        if ratio<0.5
            ratio=[ratio (1-ratio)];
        else
            ratio=[0.5,0.5]
        end
        
        feature_vecs_all=record_lists.feature_vecs_all;
        det_scores_all=cell(size(feature_vecs_all));
        
        for i=1:numel(dets_all)
            accu=dets_all{i};
            det_scores_all{i}=cellfun(@(x) getDetScore(x,ratio),accu);
        end
        
        
        empties=cellfun(@isempty,feature_vecs_all);
        to_deal=zeros(1,0);
        det_scores_all(empties)={to_deal};
        
        record_lists.test_data.y = cell2mat(det_scores_all(test_idx)')';
        record_lists.train_data.y=cell2mat(det_scores_all(train_idx)')';
        record_lists.det_scores_all=det_scores_all;
        record_lists.ratio=ratio;
        
        out_file_name=fullfile(out_dir,[models_curr{test_idx} '.mat']);
        parsave(out_file_name,record_lists);
        
    end
%     matlabpool close;
    
end
