function writeLists(out_file_name,lists,best_list_idx_gt,best_list_idx_pred)

    fid_w=fopen(out_file_name,'w');
    lists=lists([best_list_idx_gt,best_list_idx_pred]);
    fprintf(fid_w,'%d\n',numel(lists));
    fprintf(fid_w,'%s\n','C');
    for i=1:numel(lists)
        fprintf(fid_w,'%d\n',numel(lists{i}));
        for j=1:numel(lists{i})
            fprintf(fid_w,'%d\n',lists{i}(j));
        end
        fprintf(fid_w,'%s\n','C');
    end
    fclose(fid_w);
end