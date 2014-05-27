ccc

in_dir='prec_recall_auto';
mats=dir(fullfile(in_dir,'*.mat'));
mats={mats(:).name};


str_title={'Beds','Couch','Chair','Side Table','Table','All'};
for dir_no=1:numel(mats)
load(fullfile(in_dir,mats{dir_no}))


h=figure('color','w');

plot(pr_c_struct.dpm(2,2:end),pr_c_struct.dpm(1,2:end),'-or','linewidth',2);
hold on;
plot(pr_c_struct.nn_dpm(2,2:end),pr_c_struct.nn_dpm(1,2:end),'-ob','linewidth',2);

legend_strs={'DPM','Ours'};
l=legend(legend_strs);
set(l,'interpreter','none');
xlabel('Recall','Fontsize',14)
ylabel('Precision','Fontsize',14)
title(str_title{dir_no},'Fontsize',14);

end
