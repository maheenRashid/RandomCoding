ccc
parent_dir='../testingAccuracyBugForNewExperiments';
% a=dir(parent_dir);
a=struct();
a(1).name='swapObjectsInBox_allOffsets_sizeComparison_bestSortedByDPMScore_gt_html';
% a=a(10);

% return
load('names_and_folds_gt.mat');
dir_cat='camera_problem_gt/skp_category_correct';
for dir_no=1:numel(a)
    load(fullfile(parent_dir,a(dir_no).name,'boxes_kept_detail.mat'));

%     return
    cell_for_command=cell(3,size(boxes_ids,2));
    for model_no=1:size(boxes_ids,2)
        if isempty(boxes_ids{1,model_no})
            continue
        end
        if size(boxes_ids{1,model_no},1)<2
            continue;
        end
               
        model_name=boxes_ids{2,model_no};
        boxes_cats=boxes_ids{1,model_no};
        fold_no=strcmp(model_name,names_and_folds(1,:));
        fold_no=names_and_folds(2,fold_no);
        fold_no=cell2mat(fold_no);
        if numel(fold_no)~=1
            keyboard
        end
        idx=cell2mat(names_and_folds(2,:))~=fold_no;
        model_matches=names_and_folds(1,idx);
        
        cell_for_command{1,model_no}=model_name;
        cell_for_command{2,model_no}=a(dir_no).name(1:end-5);
        cell_model_matches=cell(2,size(boxes_cats,1)-1);
        
        for box_no=2:size(boxes_cats,1)
            best_cat=boxes_cats(box_no,3);
            bin=getCatIntersection(dir_cat,model_matches,best_cat);
            matches_curr=model_matches(bin);
            cell_model_matches{1,box_no-1}=matches_curr;
            cell_model_matches{2,box_no-1}=box_no-1;
        end
        cell_for_command{3,model_no}=cell_model_matches;
        %         keyboard;
        
    end
    
    save(['swapModel_moreBoxes_' a(dir_no).name '.mat'],'cell_for_command');
    
    
    
end