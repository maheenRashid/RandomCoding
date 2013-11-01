ccc
load('record_dpm.mat');
load('record_lists_clean.mat');


temp=cell(1,numel(record_lists));
[record_lists(:).accuracy]=deal(temp{:});
[record_lists(:).dpm_scores]=deal(temp{:});

ids_dpm={record_dpm(:).id};

for model_no=1:numel(record_lists)
    
    id=record_lists(model_no).id;
    id=regexpi(id,'#','split');
    id=id{end};
    record_dpm_curr=record_dpm(strcmp(id,ids_dpm));
    
    idx_on_ground=record_lists(model_no).idx_on_ground;
    idx_on_ground=idx_on_ground+1;
    lists=record_lists(model_no).lists;
    lists=cellfun(@(x) x+1,lists,'UniformOutput',0);
    box_nos=record_lists(model_no).box_nos;
    box_nos=box_nos+1; 
    bin_dpm_curr=record_dpm_curr.bin;
    obj_map=record_dpm_curr.obj_map;
    
    temp_cell=cell(1,numel(lists));
    [temp_cell{:}]=deal(zeros(size(bin_dpm_curr)));
    
    
    cmp_kept_bin_cell=cellfun(@(x) getBinFromList(x,numel(bin_dpm_curr),box_nos,idx_on_ground),lists,'UniformOutput',0);   
  
    cell_accuracy=cell(1,numel(lists));
    for i=1:numel(cell_accuracy)
        [bin_match,bin_dpm_new]=getBinMatchWithObjMap(bin_dpm_curr,obj_map,cmp_kept_bin_cell{i});
        cell_accuracy{i}=[bin_match, bin_dpm_new, cmp_kept_bin_cell{i}];
    end
    
    record_lists(model_no).accuracy=cell_accuracy;
    record_lists(model_no).dpm_scores=record_dpm_curr.boxes(:,end);
end

save('record_lists_accu.mat','record_lists');