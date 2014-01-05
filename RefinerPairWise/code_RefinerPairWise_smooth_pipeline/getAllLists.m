function [lists,success]=getAllLists(overlap_bin,timeout)
lists=cell(1,0);
start = clock;    
    
success=-1;

for i=1:size(overlap_bin,1)
%     i
%     disp(['list no ' num2str(i)])
    temp=getValidLists(i,overlap_bin,{[]});
    temp=cellfun(@(x) [x i],temp,'UniformOutput',0);
    lists=[lists temp];
    if(etime(clock,start)>=timeout)
        success=i;
        break
    end 
end
lists=cellfun(@(x) sort(x),lists,'UniformOutput',0);
sizes=cellfun(@(x) numel(x),lists);
max_size=max(sizes);
lists_mat=cellfun(@(x) [x,-1*ones(1,max_size-numel(x))],lists,'UniformOutput',0);
lists_mat=cell2mat(lists_mat');
[~,ia,~]=unique(lists_mat,'rows');
lists=lists(ia);

end