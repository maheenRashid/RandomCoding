
% load(fullfile('..','record_dpm'));


models=dir(fullfile(dir_result,'*.mat'));
models={models(:).name};
numel(models)

if ~exist(out_dir,'dir')
    mkdir(out_dir);
end

% matlabpool open;
% par
for model_no=1:numel(models)
    fprintf('%d\n',model_no);
    mod_name=models{model_no};
%     mod_name='b#bedroom#sun_aacglewqjbbpfkan.mat';
    out_mutex=fullfile(out_dir,mod_name(1:end-4));
    if ~exist(out_mutex,'dir')
        mkdir(out_mutex)
    else
        continue
    end
    
    out_file_name=fullfile(out_dir,mod_name);
    try
    temp=load(fullfile(dir_feature_vec,mod_name));
    catch
        fprintf('CONTINUING\n');
        continue;
    end
    record_lists_fl=temp.record_lists;
    temp=load (fullfile(dir_result,mod_name));
    record_lists=temp.record_lists;
    
    %get best list idx
    best_gt=record_lists.best_list_idx_gt;
    best_pred=record_lists.best_list_idx_pred;
    
    %get dpm thresh and accuracy
    accu=pruneAccuracyByThresh(record_lists_fl);
    
    %find dpm idx
    mod_name_cut=regexpi(mod_name,'#','split');
    mod_name_cut=mod_name_cut{end};
    mod_name_cut=mod_name_cut(1:end-4);
    dpm_ids={record_dpm(:).id};
    idx=find(strcmp(mod_name_cut,dpm_ids));
    
    %get cut up obj map
    obj_map=record_dpm(idx).obj_map;
    obj_map=obj_map(record_lists_fl.dpm_thresh_bin(2:end));
    total_gt=record_dpm(idx).total_gt;
    
    dpm_bin=record_lists_fl.accuracy;
    if isempty(dpm_bin)
        continue;
    end
    dpm_bin=dpm_bin{1};
    dpm_bin=dpm_bin(:,2);
    dpm_bin=dpm_bin(record_lists_fl.dpm_thresh_bin(2:end));
    
    
    
    record_accuracy=struct();
    record_accuracy.name=models{model_no};
    if isempty(best_gt)
        record_accuracy.gt=zeros(0,1);
        record_accuracy.pred=zeros(0,1);
    else
        record_accuracy.gt=accu{best_gt};
        record_accuracy.pred=accu{best_pred};
    end
    record_accuracy.total_gt=total_gt;
    record_accuracy.obj_map=obj_map;
    record_accuracy.dpm_bin=dpm_bin;
    
    parsave_accu(out_file_name,record_accuracy);
end
% matlabpool close;