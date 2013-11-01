load('stats_all_type_libsvm.mat')
% load('stats_all_type_libsvm_multiCat.mat')
bsr_all=stats_all(:,2,:);
bsr_all=reshape(bsr_all,2,7,1);
bar(bsr_all,'grouped');
bar(bsr_all','grouped');
title('Binary Classifier');
% xticklabel('a')
% set(gca,'Xtick',1:4,'XTickLabel',{'a', 'b', 'c', 'd'})

set(gca,'Xtick',1:7,'XTickLabel',{'DPM','DPM_Cat','DPM_Norm','DPM_Cat_Norm',...
'DPM_Munoz','DPM_Cat_Munoz','DPM_Cat_Norm_Munoz'})
grid on
stats_all