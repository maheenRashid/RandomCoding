ccc
load('multiCat_accu_dpm.mat','folders','prec','prec_cat');

prec_cat_multicat=prec_cat;
prec_multicat=prec;
 load('new_labels_accu_dpm.mat','folders','prec','prec_cat')
prec_cat=prec_cat(2,:,:);
prec_cat_multicat=[prec_cat_multicat;prec_cat];


prec=prec(2,:);
prec_multicat=[prec_multicat;prec];


x_labs=cell(1,2);
xlabs{1}='all det';
xlabs{2}='best det';
prec_cat=prec_cat_multicat;


leglabs={'overall','pos','neg'};
titlelabs={'bed','couch','chair','sidetable','table'};

for i=1:size(prec_cat,2)
 a=reshape(prec_cat(:,i,:),size(prec_cat,1),[]);
h=figure;
bar(a);


set(gca,'XTickLabel',xlabs)
legend(leglabs);
title(titlelabs{i});
grid on;
end


leglabs={'overall','pos','neg'};

figure;
bar(prec_multicat);


set(gca,'XTickLabel',xlabs)
legend(leglabs);



return
ccc

load('multiCat_accu_dpm.mat','folders','prec','prec_cat');

xlabs=folders;
for i=1:numel(xlabs)
    a=strfind(xlabs{i},'_');
    xlabs{i}=xlabs{i}(a(2)+1:a(end)-1);
end



leglabs={'overall','pos','neg'};
titlelabs={'bed','couch','chair','sidetable','table'};

for i=1:size(prec_cat,2)
 a=reshape(prec_cat(:,i,:),size(prec_cat,1),[]);
h=figure;
bar(a);


set(gca,'XTickLabel',xlabs)
legend(leglabs);
title(titlelabs{i});
grid on;
end







return
% load('new_labels_accu_dpm_refine.mat','folders','prec','prec_cat');
% 
% xlabs=folders;
% for i=1:numel(xlabs)
%     a=strfind(xlabs{i},'_');
%     xlabs{i}=xlabs{i}(a(2)+1:a(end)-1);
% end
% 
% 
% leglabs={'overall','pos','neg'};
% 
% figure;
% bar(prec);
% 
% 
% set(gca,'XTickLabel',xlabs)
% legend(leglabs);
% 
% grid on;
% 
% return
ccc
load('new_labels_accu_gt_refine.mat','folders','prec');

xlabs=folders;
for i=1:numel(xlabs)
    a=strfind(xlabs{i},'_');
    xlabs{i}=xlabs{i}(a(2)+1:a(end)-1);
end

leglabs={'bed','couch','chair','sidetable','table'};

figure;
bar(prec);


set(gca,'XTickLabel',xlabs)
legend(leglabs);