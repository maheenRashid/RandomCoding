ccc
% load('findingCAndSigmaForDifferentFeatures.mat');
load('findingCAndSigmaForDifferentFeatures_MultiCat.mat');

% ,'record_svm','c_pow_range','sigma_pow_range','feature_range_cell');

C_gamma_best=zeros(2,size(record_svm,3));
for fe_no=1:size(record_svm,3)
cp_all_f1=record_svm(end,:,fe_no);
test=reshape(cp_all_f1,1,1,numel(cp_all_f1));
test=cell2mat(test);
mean_test=sum(test,3);
mean_test=mean_test/5;
[max_val,max_idx]=max(mean_test(:));
[x,y]=ind2sub(size(mean_test),max_idx);

C_best=2^c_pow_range(x)
sigma_best=2^sigma_pow_range(y)
C_sigma_best(1,fe_no)=C_best;
C_sigma_best(2,fe_no)=sigma_best;
C_sigma_empirical=cell2mat(record_svm(2:3,:,fe_no))
max_val
max_empirical=cell2mat(record_svm(1,:,fe_no))
% keyboard;
end

% save('findingCAndSigmaForDifferentFeatures.mat');
save('findingCAndSigmaForDifferentFeatures_MultiCat.mat');
