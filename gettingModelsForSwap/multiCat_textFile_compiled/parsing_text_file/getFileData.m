function [cell_numbers,strs]=getFileData(data)

idx=find(cellfun(@isempty,cellfun(@(x) regexpi(x,'[0-9]'),data,'UniformOutput',0)));
strs=data(idx);
cell_numbers=cell(numel(strs),1);
idx=[idx;numel(data)+1];

for i=1:numel(idx)-1
    data_rel=data(idx(i)+1:idx(i+1)-1);
    mat=zeros(0,1);
    for j=1:numel(data_rel)
        temp=cellfun(@(x) str2num(x),regexpi(data_rel{j}(1:end-1),' ','split'));
        mat=[mat;temp];
    end
    cell_numbers{i}=mat;

end
end