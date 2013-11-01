ccc

pre='/lustre/maheenr/results_temp_09_13/'
folders={'swapObjectsInBox_allOffsets_sizeComparison_bestSortedByDPMScore_gt',...
    'swapObjectsInBox_allOffsets_sizeComparison_bestSortedByDPMScore_auto',...
    'swapObjectsInBox_allOffsets_sizeComparison_bestSortedByPredScore_gt',...
    'swapObjectsInBox_allOffsets_sizeComparison_bestSortedByPredScore_auto'};
strForDisp=cellfun(@(x) x(56:end),folders,'UniformOutput',0);

accu_mat=zeros(3,numel(folders));

for i=1:numel(folders)
    load(fullfile([pre folders{i} '_html'],'accuracy_cell.mat'));
    

bin_all=accuracy_cell(1,:)';
bin_all=cell2mat(bin_all);

accu_crude=sum(bin_all(:,1))/numel(bin_all(:,1))
labs=[0,1];
for bsr_no=1:numel(labs)
    correct=sum(bin_all(bin_all(:,2)==labs(bsr_no),1))
    total=sum(bin_all(:,2)==labs(bsr_no))
    bsr=correct/total
    accu_mat(bsr_no,i)=bsr;
end

accu_mat(3,i)=accu_crude;


end
h=figure;
 bar(accu_mat')
 title('Accuracy in Finding Correct DPM');
 
 set(gca,'XTickLabel',strForDisp)
hleg1=legend('Over all Accuracy','Positive Correct','Negative Correct');
set(hleg1,'Location','NorthEast')

 saveas(h,'accuracy_graph.png');
 save('accuracy_data.mat');