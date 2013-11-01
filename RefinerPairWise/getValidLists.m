function cell2Cat=getValidLists(idx,matrix,cell2Cat)
if nargin<3
    cell2Cat={[]};
end


validNodes=find(matrix(idx,:)>0);
matrix=matrix.*repmat(matrix(idx,:),size(matrix,1),1);
if numel(validNodes)==0
    cell2Cat={[]};
else
    for i=1:numel(validNodes)
        temp=getValidLists(validNodes(i),matrix,{[]});
        for j=1:numel(temp)
            temp{j}=[validNodes(i),temp{j}];
        end
        cell2Cat=[cell2Cat, temp];
    end
end

end