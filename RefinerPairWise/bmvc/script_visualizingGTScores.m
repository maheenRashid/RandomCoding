ccc

in_dir='gt_scores';
cam_dir='room3D_auto';
lists=dir(fullfile(in_dir,cam_dir,'*.mat'));
lists={lists(:).name};

lists_jn=cellfun(@(x) strrep(x,'.mat',''),lists,'UniformOutput',0);

scores_cell=cell(size(lists));
for i=1:numel(lists)
    x=load(fullfile(in_dir,cam_dir,lists{i}));
    scores_cell{i}=x.record_scores;
end

sorted_scores=getSortedPredScores(scores_cell);
% 
% load('scores_and_ids_merged');
% scores=sort(scores,1,'descend');
% sorted_scores=[sorted_scores scores];
% lists_jn=[lists_jn '3dgp']

% sorted_scores=sorted_scores([1,end]);
% lists_jn=lists_jn([1,end]);
str_scores=scores_cell{1}.score_strs;
sorted_scores=sorted_scores([3,end-1,1]);
leg={'Ours(Low Thresh)','Ours(High Thresh)','3DGP'};
str_scores={sprintf('%s\n%s','Surface Normals','All Pixels'),...
    sprintf('%s\n%s','Surface Normals','Object Pixels'),...
    sprintf('%s\n%s','Surface Normals','Matched Pixels'),...
    '',...
    sprintf('%s\n%s','Floorplan','Overlap')}
colors=[0.25,0.25,0.25;0.75,0.75,0.75;0,0.5,0.5];
% 
for score_no=1:numel(str_scores)
    scores=cell2mat(cellfun(@(x) x(:,score_no),sorted_scores,'UniformOutput',0));
    figure;
    hold on;
    t=title(str_scores{score_no});
    set(t,'fontsize',14);
    
    scores=flipud(scores);
    x_no=1:size(scores,1);
    x_no=x_no/numel(x_no);
    x_no=x_no*100;
    for i=1:size(scores,2)
    plot(x_no,scores(:,i),'color',colors(i,:),'linewidth',3);
    end
    set(gca,'fontsize',14);
    l=legend(leg,'Location','NorthWest');
    set(l,'interpreter','none','fontsize',12);
    xlabel('Percentile');
    ylabel('Score');
    set(gcf,'color','w');
end

avgs=cellfun(@(x) mean(x,1),sorted_scores,'UniformOutput',0);
h=figure('color','w'); 
avgs_rel=avgs;
% ([3,end-1,1]);

h=bar(cell2mat(avgs_rel')');
% set(h,'color','w');
legend_strs={'Ours Low DPM Thresh','Ours High DPM Thresh','3DGP'};
l=legend(legend_strs);
set(l,'interpreter','none');
set(gca,'XTickLabel',{'','','','',''})
% xlabel('Pixelwise Overlap Score Threshold','Fontsize',14)
ylabel('Accuracy','Fontsize',14)
set(gcf,'color','w');