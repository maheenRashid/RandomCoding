% ccc
% load('data_auto.mat');
% load('names_and_scores_gt.mat');
% names_and_scores_gt=names_and_scores;
% load('names_and_scores_auto.mat');
% names_and_scores_auto=names_and_scores;
% 
% 
% idx=cellfun(@isempty,names_and_scores_auto(1,:));
% names_and_scores_auto(:,idx)=[];
% idx=cellfun(@isempty,names_and_scores_gt(1,:));
% names_and_scores_gt(:,idx)=[];
% 
% [C,ia,ib] = intersect(names_and_scores_gt(1,:),names_and_scores_auto(1,:));
% names_and_scores_gt=names_and_scores_gt(:,ia);
% names_and_scores_auto=names_and_scores_auto(:,ib);
% 
% 
% 
% data_curr=detailedData{1};
% 
% [C,ia,ib] = intersect(data_curr(1,:),names_and_scores_auto(1,:));
% 
% scores_curr=cell(1,size(data_curr,2));
% for i=1:numel(scores_curr)
%     temp=data_curr{2,i};
%     scores_curr{i}=[temp,data_curr{3,i}];
% end
% 
% scores_curr=scores_curr(ia);
% 
% scores_mine_auto=names_and_scores_auto(2,ib);
% scores_mine_gt=names_and_scores_gt(2,ib);
% 
% 
% data_bar=zeros(3,5);
% avg_3dnn=cell2mat(scores_curr');
% avg_3dnn=mean(avg_3dnn,1);
% data_bar(1,:)=avg_3dnn(2:end);
% 
% avg_auto=cell2mat(scores_mine_auto');
% avg_auto=avg_auto(2:2:end,2:end);
% avg_auto=mean(avg_auto,1);
% data_bar(2,:)=avg_auto;
% 
% avg_gt=cell2mat(scores_mine_gt');
% avg_gt=avg_gt(2:2:end,2:end);
% avg_gt=mean(avg_gt,1);
% data_bar(3,:)=avg_gt;
% 
% figure;
% bar(data_bar');
% set(gca,'XTickLabel',{'GT_SCORE_all_px',...
%     'GT_SCORE_obj_px','GT_SCORE_obj_px_strict','GT_SCORE_match_px','Floorplan_Overlap'})
% hleg1=legend('3DNN','DPM Auto Layout','DPM Groundtruth Layout');
% set(hleg1,'Location','NorthEast')
% return
scores_curr_copy=scores_curr;
for i=1:size(scores_curr,2)
    scores_curr_copy{i}=[scores_mine_auto{i}(1,:);scores_curr{i}];
end
addpath('../');

str_graphs={'Predicted_Scores','GT_SCORE_all_px',...
    'GT_SCORE_obj_px','GT_SCORE_obj_px_strict','GT_SCORE_match_px','Floorplan_Overlap'};

[h_all,idx_sorted_auto,diff_sorted_auto]=getGraphsDiff(scores_mine_auto,str_graphs)
close all

[h_all,idx_sorted_gt,diff_sorted_gt]=getGraphsDiff(scores_mine_gt,str_graphs)
close all

[h_all_3dnn,idx_sorted_3dnn,diff_sorted_3dnn]=getGraphsDiff(scores_curr_copy,str_graphs)
close all
for i=1:numel(diff_sorted_auto)

    h=figure;
    ylabel('delta');
        grid on
hold on;
plot(diff_sorted_3dnn{i},'-b');
plot(diff_sorted_auto{i},'-g');
plot(diff_sorted_gt{i},'-r');

th=title(str_graphs{i});
        set(th,'interpreter','none');
        hleg1=legend('3DNN','DPM Auto Layout','DPM Groundtruth Layout');
        set(hleg1,'Location','NorthWest')
        saveas(h,[str_graphs{i} '_comp.png']);
end