
models=cellfun(@(x) x(1:end-4),models,'UniformOutput',0);
ids_dpm={record_dpm(:).id};

% matlabpool open
% par
for model_no=1:numel(models)
    fprintf('%d of %d\n',model_no,numel(models));
    out_mutex=fullfile(out_dir,models{model_no});
    if ~exist(out_mutex,'dir')
        mkdir(out_mutex)
    else
        fprintf('continuing\n');
        continue
    end
    
    temp=load(fullfile(dir_lists,[models{model_no} '.mat']));
    record_lists=temp.record_lists;
    if isempty(record_lists.lists)
        continue
    end
    id=models{model_no};
    id=regexpi(id,'#','split');
    id=id{end};
    check=sum(strcmp(id,ids_dpm));
    if check==0
        continue
    end
    
    out_file_name=fullfile(out_dir,[models{model_no} '.mat']);
    
    record_dpm_curr=record_dpm(strcmp(id,ids_dpm));
    idx_on_ground=record_lists.idx_on_ground;
    idx_on_ground=idx_on_ground+1;
    lists=record_lists.lists;
    lists=cellfun(@(x) x+1,lists,'UniformOutput',0);
    box_nos=record_lists.box_nos;
    box_nos=box_nos+1;
    bin_dpm_curr=record_dpm_curr.bin;
    obj_map=record_dpm_curr.obj_map;
    
    temp_cell=cell(1,numel(lists));
    [temp_cell{:}]=deal(zeros(size(bin_dpm_curr)));
    
    
    cmp_kept_bin_cell=cellfun(@(x) getBinFromList(x,numel(bin_dpm_curr),...
        box_nos,idx_on_ground),lists,'UniformOutput',0);
    
    cell_accuracy=cell(1,numel(lists));
    for i=1:numel(cell_accuracy)
        [bin_match,bin_dpm_new]=getBinMatchWithObjMap(bin_dpm_curr,obj_map,cmp_kept_bin_cell{i});
        cell_accuracy{i}=[bin_match, bin_dpm_new, cmp_kept_bin_cell{i}];
    end
    
    record_lists.accuracy=cell_accuracy;
    record_lists.dpm_scores=record_dpm_curr.boxes(:,end);
    record_lists.cat_nos=record_dpm_curr.cat_no;
  
    parsave(out_file_name,record_lists);
    
end
% matlabpool close;
