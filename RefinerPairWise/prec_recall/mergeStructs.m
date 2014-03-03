function a=mergeStructs(a,b)

names = fieldnames(b);
for i=1:numel(names)
    evalc(['a.' names{i} '=b.' names{i}]);
end


end