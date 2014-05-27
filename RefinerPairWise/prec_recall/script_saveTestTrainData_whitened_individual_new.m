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
    fold_no
    out_mutex=fullfile(out_dir,num2str(fold_no));
    
    %check existence
    to_load_file=fullfile(out_mutex,[num2str(fold_no) '_unitLength.mat']);
    
    if ~exist(to_load_file,'file')
%         fprintf('%s\n',to_load_file);
%         to_del=fullfile(out_dir,[num2str(fold_no) '_unitLength']);
%         if exist(to_del,'dir')
%             rmdir(to_del);
%         end
        continue;
    end
    
    load(to_load_file,'models_curr','feature_vecs_all','det_scores_all','ratio');
%     load(to_load_file,'models_curr');
    
%     idx=find(strcmp('b#bedroom#sun_aaiboxbydyoflaey',models_curr));
%     idx
%     fold_no
%     
%     keyboard;
%     continue;
%     matlabpool open
%     par
    for test_idx=1:numel(models_curr)
        fprintf('test_idx %d\n',test_idx);
        train_idx=1:numel(models_curr);
        train_idx(test_idx)=[];
        
        out_mutex=fullfile(out_dir,[models_curr{test_idx}]);
        if ~exist(out_mutex,'dir')
            mkdir(out_mutex);
        else
            continue;
        end
        
        out_file_name=fullfile(out_dir,[models_curr{test_idx} '.mat']);
        
        [train_data,test_data]=getTrainTestDataWhitened...
            (feature_vecs_all,det_scores_all,test_idx,train_idx);

        if isempty(train_data.X)
            fprintf('empty train_data \n');
            continue;
        end
        
        record_data=struct();
        record_data.models_curr=models_curr;
        record_data.test_idx=test_idx;
        record_data.train_idx=train_idx;
        record_data.ratio=ratio;
        record_data.test_data=test_data;
        record_data.train_data=train_data;
        record_data.feature_vecs_all=feature_vecs_all;
        record_data.det_scores_all=det_scores_all;
        parsave(out_file_name,record_data);

    end

end

