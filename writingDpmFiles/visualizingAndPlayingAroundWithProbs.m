ccc

for svm_type_no=1:7
svm_type_str={'libsvm_dpm','libsvm_dpm_cat','libsvm_dpm_norm','libsvm_dpm_cat_norm',...
    'libsvm_dpm_munoz','libsvm_dpm_cat_munoz','libsvm_dpm_cat_norm_munoz'};
dir_in_pre='gt_models';
dir_in_post='Img_GT_Features';

svm_type_curr=svm_type_str{svm_type_no};
% load(fullfile(svm_type_curr,[svm_type_curr '.mat']));
% 
% thresh=0.1;
% 
% for gt_no=1:numel(gt_list)
%     if isempty(pred_vs_real{1,gt_no})
%         continue
%     end
%     order_curr=svm_struct_cell{1,gt_no}.Label;
%     bsr_curr=pred_vs_real{2,gt_no};
%     dec_curr=pred_vs_real{3,gt_no};
%     gt_box=pred_vs_real{1,gt_no}(:,1);
%     pred_box=pred_vs_real{1,gt_no}(:,2);
%     
%     dec_curr=orderDecisionColumns(dec_curr,pred_box);
%     pred_dec=zeros(size(pred_box));
%     
%     pred_dec(dec_curr(:,1)>=thresh)=1;
% %     [gt_box,pred_box,pred_dec]
%     pred_vs_real{1,gt_no}=[gt_box,pred_box,pred_dec];
%     pred_vs_real{3,gt_no}=dec_curr;
% %     keyboard;
% end
load(fullfile(svm_type_curr,[svm_type_curr '_withThreshAndDecValSort.mat']));

gt_box_all=cell2mat(pred_vs_real(1,:)');
pred_box_all=gt_box_all(:,2);
pred_box_thresh_all=gt_box_all(:,3);
gt_box_all=gt_box_all(:,1);

[accu_all,bsr_all,one_right_all,zero_right_all]=getAccuracyStats(gt_box_all,pred_box_all)

[accu_all_thresh,bsr_all_thresh,one_right_all_thresh,zero_right_all_thresh]=getAccuracyStats(gt_box_all,pred_box_thresh_all)


stats_all(1,1,svm_type_no)=accu_all;
stats_all(1,2,svm_type_no)=bsr_all;
stats_all(1,3,svm_type_no)=one_right_all;
stats_all(1,4,svm_type_no)=zero_right_all;

stats_all(2,1,svm_type_no)=accu_all_thresh;
stats_all(2,2,svm_type_no)=bsr_all_thresh;
stats_all(2,3,svm_type_no)=one_right_all_thresh;
stats_all(2,4,svm_type_no)=zero_right_all_thresh;
end
save('stats_all_type_libsvm.mat','stats_all');
% return





% for svm_type_no=1:7
% svm_type_str={'libsvm_dpm','libsvm_dpm_cat','libsvm_dpm_norm','libsvm_dpm_cat_norm',...
%     'libsvm_dpm_munoz','libsvm_dpm_cat_munoz','libsvm_dpm_cat_norm_munoz'};
% dir_in_pre='gt_models';
% dir_in_post='Img_GT_Features';
% 
% svm_type_curr=svm_type_str{svm_type_no};
% load(fullfile(svm_type_curr,[svm_type_curr '_withThreshAndDecValSort.mat']));
% 
% for gt_no=1:numel(gt_list)
%     name_curr=gt_list{gt_no};
%     if isempty(pred_vs_real{1,gt_no})
%         continue;
%     end
%     
%     
%     gt_box=pred_vs_real{1,gt_no}(:,1);
%     pred_box=pred_vs_real{1,gt_no}(:,2);
%     pred_dec=pred_vs_real{1,gt_no}(:,3);
%     
%     im=imread(fullfile(dir_in_pre,name_curr,dir_in_post,'object_mask_overlay.png'));
%     feature_curr=dpm_svm_data{1,gt_no};
%     
%     [h,h1]=visualizeBoxPreds(im,feature_curr,gt_box,pred_box);
%     [h_temp,h_new]=visualizeBoxPreds(im,feature_curr,gt_box,pred_dec);
%     close(h_temp);
% 
%     saveas(h,fullfile(svm_type_curr,[name_curr '_gt.png']));
%     saveas(h1,fullfile(svm_type_curr,[name_curr '_pred.png']));
%     saveas(h_new,fullfile(svm_type_curr,[name_curr '_pred_thresh.png']));
%     
%     close(h);
%     close(h1);
%     close(h_new);
%     
% end
% end



for svm_type_no=1:7
svm_type_str={'libsvm_dpm','libsvm_dpm_cat','libsvm_dpm_norm','libsvm_dpm_cat_norm',...
    'libsvm_dpm_munoz','libsvm_dpm_cat_munoz','libsvm_dpm_cat_norm_munoz'};
dir_in_pre='gt_models';
dir_in_post='Img_GT_Features';

svm_type_curr=svm_type_str{svm_type_no};
load(fullfile(svm_type_curr,[svm_type_curr '_withThreshAndDecValSort.mat']));

fid_html=fopen(fullfile(svm_type_curr,'results.html'),'w');
fprintf(fid_html,'%s\n','<html>');
for gt_no=1:numel(gt_list)
    id=gt_list{gt_no};
    if isempty(pred_vs_real{1,gt_no})
        continue;
    end
    id=strrep(id,'#','%23');
%     fprintf(fid_html,'%s\n',[num2str(accuracy(1)) '<br>']);
%     fprintf(fid_html,'%s\n',[num2str(accuracy(2)) '<br>']);
    fprintf(fid_html,'%s\n',['<img width="25%" src="' fullfile([id '_gt.png']) '">']);
    fprintf(fid_html,'%s\n',['<img width="25%" src="' fullfile([id '_pred.png']) '">']);
    fprintf(fid_html,'%s\n',['<img width="25%" src="' fullfile([id '_pred_thresh.png']) '">']);
    fprintf(fid_html,'%s\n','<br>');
end
fprintf(fid_html,'%s\n','<html>');
fclose(fid_html);
end