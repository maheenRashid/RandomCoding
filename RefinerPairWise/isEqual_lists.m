function [bin]=isEqual_lists(lists_it,lists)


lists_it_str=cellfun(@num2str,lists_it,'UniformOutput',0);
lists_str=cellfun(@num2str,lists,'UniformOutput',0);

int=intersect(lists_str,lists_it_str);
if numel(lists_str)==numel(int) && numel(lists_it_str)==numel(int)
    bin=true;
else
    bin=false;
end


end