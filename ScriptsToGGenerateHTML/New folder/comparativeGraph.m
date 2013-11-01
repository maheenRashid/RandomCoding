ccc

load('data_auto.mat');
load('names_and_scores.mat')
data_curr=detailedData{1};

idx=cellfun(@isempty,names_and_scores(1,:));
names_and_scores(:,idx)=[];
[C,ia,ib] = intersect(data_curr(1,:),names_and_scores(1,:));


scores_curr=cell(1,size(data_curr,2));
for i=1:numel(scores_curr)
    temp=data_curr{2,i};
    scores_curr{i}=[temp,data_curr{3,i}];
end

scores_curr=scores_curr(ia);

scores_mine=names_and_scores(2,ib);

scores_curr_copy=scores_curr;
for i=1:size(scores_curr,2)
    scores_curr_copy{i}=[scores_mine{i}(1,:);scores_curr{i}];
end
addpath('../');

str_graphs={'Predicted_Scores','GT_SCORE_all_px',...
    'GT_SCORE_obj_px','GT_SCORE_obj_px_strict','GT_SCORE_match_px','Floorplan_Overlap'};

[h_all,idx_sorted,diff_sorted]=getGraphsDiff(scores_mine,str_graphs)
close all
[h_all_3dnn,idx_sorted_3dnn,diff_sorted_3dnn]=getGraphsDiff(scores_curr_copy,str_graphs)
close all
for i=1:numel(diff_sorted)

    h=figure;
plot(diff_sorted{i},'-b');
hold on;
plot(diff_sorted_3dnn{i},'-r');
th=title(str_graphs{i});
        set(th,'interpreter','none');
        saveas(h,[str_graphs{i} '_comp.png']);
end