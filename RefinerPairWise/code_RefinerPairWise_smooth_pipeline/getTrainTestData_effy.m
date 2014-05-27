function [train_data,test_data]=getTrainTestData_effy(feature_vecs_all,det_scores_all,test_idx,train_idx)

%create test/train data
% keyboard
test_data.X = cell2mat(feature_vecs_all(test_idx));
test_data.y = cell2mat(det_scores_all(test_idx))';
train_data.X=cell2mat(feature_vecs_all(train_idx));
train_data.y=cell2mat(det_scores_all(train_idx))';

% train_data.X=normr(train_data.X);
% test_data.X=normr(test_data.X);

train_data.X=normalize(train_data.X);
test_data.X=normalize(test_data.X);


end


function [data]=normalize(data)

norms=zeros(size(data,1),1);
size(data,1)
tic();
matlabpool open
parfor i=1:size(data,1)
    fprintf('%d\n',i);
    norm_curr=norm(data(i,:));
    data(i,:)=bsxfun(@rdivide,data(i,:),norm_curr);
end
matlabpool close
toc();

% data=bsxfun(@rdivide,data,norms);

end