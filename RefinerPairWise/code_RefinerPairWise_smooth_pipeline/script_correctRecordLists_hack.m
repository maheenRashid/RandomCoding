x=load(fullfile(cam_dir_meta,gt_dir,'best_swap_overlap.mat'));
models=x.models;
models=cellfun(@(x) x(1:end-4),models,'UniformOutput',0);
swap_info=x.swap_infos;

for model_no=1:numel(names)
    load(fullfile(out_dir,[names{model_no} '.mat']),'record_lists');
    idx=strcmp(names{model_no},models);
    swap_info_curr=swap_info(idx,:);
    swap_3=swap_info_curr{end};
    swap_2=swap_info_curr{2};
    idx_match=zeros(size(swap_2,1),1);
    for box_no=1:size(swap_2,1)
        idx_match(box_no)=find(ismember(swap_3,swap_2(box_no,:)));
    end
    idx_match=idx_match-1;
    
    %remove neg lists
    [bin_neg]=getBinNeg(record_lists.box_nos,record_lists.box_dim);
    black_list=find(bin_neg);
    black_list=black_list-1;
    list_bin=cellfun(@(x) sum(ismember(x,black_list)),record_lists.lists);
    list_bin=list_bin>0;
    
    record_lists.lists(list_bin)=[];
    record_lists.scores(list_bin)=[];
    record_lists.gt_scores(list_bin,:)=[];

    %replace list idx with idx_match
    
    
    %save
    
end