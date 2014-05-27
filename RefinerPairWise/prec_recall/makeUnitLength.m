function [data]=makeUnitLength(data)

if iscell(data)
%     matlabpool open;
%     par
    for i=1:numel(data)
        data{i}=normalize(data{i});
    end
%     matlabpool close;
else
    data=normalize(data);
end

end

function [data]=normalize(data)

% fprintf('%d\n',size(data,1));
if size(data,1)>10000
%     tic()
    matlabpool open
    parfor i=1:size(data,1)
        norm_curr=norm(data(i,:));
        data(i,:)=bsxfun(@rdivide,data(i,:),norm_curr);
    end
    matlabpool close
%     toc()
else
%     tic()
    for i=1:size(data,1)
        norm_curr=norm(data(i,:));
        data(i,:)=bsxfun(@rdivide,data(i,:),norm_curr);
    end
%     toc()
end


end