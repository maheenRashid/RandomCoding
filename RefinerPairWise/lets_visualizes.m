ccc

load('lets_visualizes.mat');

scores_mat=cell2mat(scores);
det_scores_mat=cell2mat(det_scores);
bsrs_mat=cell2mat(bsrs);


% bsr_pred=zeros(1,60);
% for i=1:60
% %     load(fullfile(dir_dpm_bin,[models{model_no} '.mat']));
%     det_score_pred=weights_final'*scores{i};
%     [det_score_pred_sort,sort_idx_pred]=sort(det_score_pred,'descend');
%     bsr_pred(i)=bsrs{i}(sort_idx_pred(1));
% %     [det_score_sort,sort_idx]=sort(record_lists.det_score,'descend');
% %     bsr_gt=record_lists.bsr(sort_idx);
% %     
% end


scores_mat_w=scores_mat.*repmat(weights_final,1,size(scores_mat,2));
figure;
hold on;
for i=1:50:numel(bsrs_mat)
  alpha=bsrs_mat(i);
  color=[alpha*1,0,(1-alpha)*1];
  plot(scores_mat_w(1,i),scores_mat_w(2,i),'o','Color',color,'markersize',3);
  
end


% for model_no=1:10:60
%     bsrs_mat=bsrs{model_no};
%     scores_mat=scores{model_no};
% figure;
% hold on;
% for i=1:numel(bsrs_mat)
% alpha=bsrs_mat(i);
%     color=[alpha*1,0,(1-alpha)*1];
%     plot(scores_mat(1,i),scores_mat(2,i),'o','Color',color,'markersize',3);
% %     ,'linewidth',3);
% end
% end

