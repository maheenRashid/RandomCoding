ccc

load('gt_list_and_fold.mat','gt_list','gt_folds');

dir_in_pre='gt_models';
dir_in_post='Img_GT_Features';
errorLog=cell(1,0);
boxes_and_labels_all=cell(2,numel(gt_list));

for file_no=1:numel(gt_list)
    file_no
    gt_list{file_no}
    im_path=fullfile(dir_in_pre,gt_list{file_no},dir_in_post,'object_mask.png')
    % return
    if ~exist(im_path,'file')
        errorLog=[errorLog,gt_list{file_no}];
        continue;
    end
    catMask=imread(im_path);
    
    [boxes, labels]=getBoxesAndLabels(catMask);
    boxes_and_labels_all{1,file_no}=boxes;
    boxes_and_labels_all{2,file_no}=labels;
end
save('gt_list.mat','gt_list','boxes_and_labels_all','errorLog','gt_folds');

