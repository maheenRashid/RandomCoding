ccc

in_dir='pix_overlap_auto';

cat_no=2;
load(fullfile(in_dir,['dets_compiled_' num2str(cat_no) '.mat']));
idx=[2,7,8,9];
legend_strs=best_lists(idx);
[threshes_rep,det_rates]=renderPixelWise(det_record_cell,idx,threshes);
h=figure('color','w'); 
% plot(threshes_rep',det_rates','linewidth',3,'-r');
% ,'-r','-g','-b'});
hold on;

strs_plot={'--r','-r','-g','-b'};
colors=[0.25,0.25,0.25;0.75,0.75,0.75;0.5,0.5,0;0,0.5,0.5];
for i=1:size(det_rates,1)
    thresh_curr=threshes_rep(i,:);
    det_curr=det_rates(i,:);
    plot(thresh_curr',det_curr','color',colors(i,:),'linewidth',3);
end

legend_strs={'Ours Low DPM Thresh','Ours High DPM Thresh','3DNN','3DGP'};
l=legend(legend_strs);
set(l,'interpreter','none');
xlabel('Pixelwise Overlap Score Threshold','Fontsize',14)
ylabel('Detection Rate','Fontsize',14)
title('Sofa','fontsize',14);
set(gca,'Color','w','fontsize',14);

return
ccc
in_dir='pix_overlap_auto';
load(fullfile(in_dir,'bed_det_record.mat'));

load(fullfile(in_dir,'dets_compiled_1.mat'));

[det_record(:).id]=deal(det_record(:).name);
[det_record(:).det_overlap]=deal(det_record(:).detects);
det_record=rmfield(det_record,{'name','detects','overlaps'});

det_record_cell=[det_record_cell det_record];
best_lists=[best_lists, '3dgp'];
save(fullfile(in_dir,'dets_compiled_1.mat'),'det_record_cell',...
    'best_lists','threshes');

return
ccc

path_to_3dgp='D:\3DGP\indoorunderstanding_3dgp-master\scott_pixelWiseOverlap_3dgp';
out_dir=fullfile(pwd,'pix_overlap_auto');
mats=dir(fullfile(path_to_3dgp,'*.mat'));
for i=1:numel(mats)
    copyfile(fullfile(path_to_3dgp,mats(i).name),fullfile(out_dir,mats(i).name));
end

return
ccc

load('bed_det_record.mat');
det_rate=getDetRate({det_record.detects},[0.5:0.05:1]);

cat_no=1;

load(['dets_compiled_' num2str(cat_no) '.mat'],'det_rates_cell','threshes','dirs');

det_rates_cell=[det_rates_cell,det_rate];
det_rates=cell2mat(det_rates_cell');
% det_rates=det_rates(2:2:end,:);
threshes_rep=repmat(threshes,size(det_rates,1),1);
figure; plot(threshes_rep',det_rates');


