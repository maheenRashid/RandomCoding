ccc
load('data_auto.mat');
data_curr=detailedData{1};
scores_curr=cell(1,size(data_curr,2));
for i=1:numel(scores_curr)
    temp=data_curr{2,i};
    scores_curr{i}=[temp,data_curr{3,i}];
end


names_and_scores_all=cell(2,2);
names_and_scores_all{1,1}=data_curr(1,:);
names_and_scores_all{2,1}=scores_curr;


% pre='/lustre/maheenr/results_temp_09_13/'

pre='E:\RandomCoding\testingAccuracyBugForNewExperiments\'
folders={'swapModelInBox_bestSortedByDPMScore_auto'};
strForDisp=cellfun(@(x) x(16:end),folders,'UniformOutput',0);
strForDisp=['3DNN',strForDisp];
str_col={'-r','-g','-b','-y','-m'};
str_graphs={'Predicted_Scores','GT_SCORE_all_px',...
    'GT_SCORE_obj_px','GT_SCORE_obj_px_strict','GT_SCORE_match_px','Floorplan_Overlap'};


for i=1:numel(folders)
    load(fullfile([pre folders{i} '_html'],'names_and_scores.mat'));
    idx=~cellfun(@isempty,names_and_scores(3,:));
    names_and_scores_all{1,i+1}=names_and_scores(1,idx);
    names_and_scores_all{2,i+1}=names_and_scores(3,idx);
    
end

% exp_no=1;
for exp_no1=1:size(names_and_scores_all,2)
    for exp_no=1:size(names_and_scores_all,2)
        
        [C,ia,ib] = intersect(names_and_scores_all{1,exp_no},names_and_scores_all{1,exp_no1});
        names_and_scores_all{1,exp_no}=names_and_scores_all{1,exp_no}(:,ia);
        names_and_scores_all{2,exp_no}=names_and_scores_all{2,exp_no}(:,ia);
        
        names_and_scores_all{1,exp_no1}=names_and_scores_all{1,exp_no1}(:,ib);
        names_and_scores_all{2,exp_no1}=names_and_scores_all{2,exp_no1}(:,ib);
    end
end

scores_curr_copy=names_and_scores_all{2,1};
scores_mine_auto=names_and_scores_all{2,2};
for i=1:size(scores_curr_copy,2)
    scores_curr_copy{i}=[scores_mine_auto{i}(1,:);scores_curr_copy{i}];
end
names_and_scores_all{2,1}=scores_curr_copy;

averages=zeros(size(names_and_scores_all,2),5);
for i=1:size(averages,1)
    avg_curr=cell2mat(names_and_scores_all{2,i}');
    avg_curr=avg_curr(2:2:end,2:end);
    avg_curr=mean(avg_curr,1);
    averages(i,:)=avg_curr;
end

h_avg=figure;
bar(averages');
set(gca,'XTickLabel',str_graphs(2:end))
hleg1=legend(strForDisp);
title('Average Scores');
set(hleg1,'interpreter','none');
set(hleg1,'Location','NorthEast')
grid on
set(h_avg, 'Position', get(0,'Screensize'))
saveas(h_avg,'average_scores.png');

diffs_sorted=cell(1,size(names_and_scores_all,2))

for i=1:size(diffs_sorted,2)
    [h_all,~,diff_sorted_curr]=getGraphsDiff(names_and_scores_all{2,i},str_graphs);
    diffs_sorted{i}=diff_sorted_curr;
    for h_no=1:numel(h_all)
        close(h_all(h_no))
    end
end

for i=1:numel(diffs_sorted{1})
    h=figure;
    ylabel=('delta');
    grid on;
    hold on;
    for j=1:numel(diffs_sorted)
        plot(diffs_sorted{j}{i},str_col{j});
    end
    th=title(str_graphs{i});
    set(th,'interpreter','none');
    
    hleg1=legend(strForDisp);
    set(hleg1,'interpreter','none');
    set(hleg1,'Location','NorthWest')
    set(h, 'Position', get(0,'Screensize'))
    saveas(h,[str_graphs{i} '_comp.png']);
    
end
