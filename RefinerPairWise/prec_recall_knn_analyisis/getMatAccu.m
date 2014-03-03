function [aps,prec,recall]=getMatAccu(in_dir,k_vec,str_file,str_struct)
% keyboard;
if ~isempty(k_vec)
k_str=num2cell(k_vec);
k_str=cellfun(@num2str,k_str,'UniformOutput',0);
files=cellfun(@(x) [x str_file],k_str,'UniformOutput',0);
else
    files={str_file};
end
prec_recall=cell(1,numel(files));
for i=1:numel(files)
    file_data=load(fullfile(in_dir,files{i}));
    prec_recall{i}=eval(['file_data.' str_struct]);
end

prec_recall_mat=cell2mat(prec_recall');
prec=prec_recall_mat(1:2:end,:);
recall=prec_recall_mat(2:2:end,:);
% figure; plot(recall',prec');
% legend(k_str);
% grid on;
% xlim([0,1]);
% ylim([0,1]);

aps=zeros(size(prec,1),1);
for i=1:size(prec,1)
    aps(i)=getAP(prec(i,:),recall(i,:));
end

end