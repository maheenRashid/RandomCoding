function [h_all,idx_sorted,diff_sorted]=getGraphsDiff(scores_cell,str_graphs)
    h_all=zeros(1,numel(str_graphs));
    diffs=cellfun(@diff,scores_cell,'UniformOutput',0);
    diffs=diffs';
    diffs=cell2mat(diffs);
    idx_sorted=cell(1,numel(str_graphs));
    diff_sorted=cell(1,numel(str_graphs));
    for i=1:numel(str_graphs)
        diff_curr=diffs(:,i);
        [val_sort,idx_sort_curr]=sort(diff_curr);
        h_all(i)=figure;
        plot(val_sort,'-r','LineWidth',3);
        ylabel('delta');
        grid on
        th=title(str_graphs{i});
        set(th,'interpreter','none');
        idx_sorted{i}=idx_sort_curr;
        diff_sorted{i}=val_sort;
    end
end