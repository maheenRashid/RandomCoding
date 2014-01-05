

folder=folders{folder_no};

top3=load(fullfile(dir_parent,folder,['record_box_info_all_unique_top_' ...
    num2str(n) '.mat']),'record_box_info_all');

top10=load(fullfile(dir_parent,folder,['record_box_info_all_unique_top_' ...
    num2str(10) '.mat']),'record_box_info_all');

record_box_info_all=top3.record_box_info_all;
[record_box_info_all(:).mapping]=deal({});



for id_no=1:numel(record_box_info_all)
    
    id_curr=top3.record_box_info_all(id_no).id;
    idx_curr=strcmp(id_curr,{top10.record_box_info_all(:).id});
    
    [~,idx_top3,idx_top10]=intersect(top3.record_box_info_all(idx_curr).swap_info,...
        top10.record_box_info_all(id_no).swap_info,'rows');
    
    [~,sort_idx]=sort(idx_top3);
    idx_top10=idx_top10(sort_idx);
    record_box_info_all(id_no).mapping=idx_top10;
    
end

save(fullfile(dir_parent,folder,['record_box_info_all_unique_top_' ...
    num2str(n) '.mat']),'record_box_info_all');
