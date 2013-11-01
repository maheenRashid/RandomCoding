function [lists] = getAllLists_it(bin)

n=size(bin,1);
cell_edge=cell(n,1);
for i=1:n
    cell_edge{i}=find(bin(i,:));
end

cell_lists=cell(n,1);

for i=1:n
    i
    edge_curr=cell_edge{i};
    edge_less=edge_curr(edge_curr<i);
    edge_more=edge_curr(edge_curr>i);
    
    for j=1:numel(edge_less)
        edge_idx=edge_less(j);
        cell_lists{edge_idx}=addToLists(i,edge_less,[edge_idx edge_more],cell_lists{edge_idx});
    end
    
    cell_list_curr=cellfun(@(x) [i x], num2cell(edge_more),'UniformOutput',0);
    cell_lists{i}=cell_list_curr;
end

for i=1:numel(cell_lists)
    cell_lists{i}=[cell_lists{i} {i}];
end

total=cellfun(@(x) numel(x),cell_lists);
total=sum(total);
lists=cell(1,total);
idx_prev=1;
for i=1:numel(cell_lists)
    lists(idx_prev:numel(cell_lists{i})+idx_prev-1)=cell_lists{i}(:);
    idx_prev=idx_prev+numel(cell_lists{i});
end

end


function new_list=addToLists(idx,edge_less,edge_more,old_list)

    bin_list=cellfun(@(x) isOnlyEdge(edge_less,edge_more,x),old_list,'UniformOutput',0);
    bin_list=cell2mat(bin_list);
    new_list=old_list(bin_list);
    new_list=cellfun(@(x) [x idx],new_list,'UniformOutput',0);
    new_list=cellfun(@sort,new_list,'UniformOutput',0);
    new_list=[new_list old_list];

end


function bin =isOnlyEdge(edge_less,edge_more,x)
    int=intersect(x,[edge_more,edge_less]);
    int_less=intersect(x,edge_less);
    bin= numel(int)==numel(x) && numel(int_less)~=numel(x);
end