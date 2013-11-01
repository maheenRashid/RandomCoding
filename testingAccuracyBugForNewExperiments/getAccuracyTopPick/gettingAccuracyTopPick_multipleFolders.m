ccc
pre='E:\RandomCoding\testingAccuracyBugForNewExperiments\'
folders={'swapObjectsInBox_allOffsets_sizeComparison_bestSortedByDPMScore_gt',...
    'swapObjectsInBox_allOffsets_sizeComparison_bestSortedByDPMScore_auto',...
    'swapObjectsInBox_allOffsets_sizeComparison_bestSortedByPredScore_gt',...
    'swapObjectsInBox_allOffsets_sizeComparison_bestSortedByPredScore_auto'};
strForDisp=cellfun(@(x) x(56:end),folders,'UniformOutput',0);


for i=1
    %     :numel(folders)
    load(fullfile(pre,[folders{i} '_html'],'accuracy_cell_cmp_kept.mat'));
    idx=find(cellfun(@isempty,accuracy_cell(1,:)));
    
    
    accuracy_cell(:,idx)=[];
    
    
    top_picks=zeros(size(accuracy_cell,2),2);
    idx_faulty=zeros(0,1);
    for mod_no=1:size(accuracy_cell,2)
        accu_curr=accuracy_cell{1,mod_no};
        idx=find(accu_curr(:,3)>0);
        if sum(accu_curr(:,2))==0
            idx_faulty=[idx_faulty;mod_no];
        end
        top_picks(mod_no,:)=accu_curr(idx(1),[1,3]);
    end
    
    
    
end
