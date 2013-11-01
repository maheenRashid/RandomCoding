ccc
in_dir='D:\ResearchCMU\lustre\jasonli1\code\MATLAB\maheen_dataForGTModels';
pred_list=dir(fullfile(in_dir,'predAndFileNamesCompiled*'));


namesAndOrientAll_ultimate=cell(0,2);
predAndDirCell_ultimate=cell(2,16);
for i=1:numel(pred_list)
    load(fullfile(in_dir,pred_list(i).name));
    if i>1
        [namesAndOrientAll_ultimate,predAndDirCell_ultimate]=getRidOfOldNames(namesAndOrientAll_ultimate,predAndDirCell_ultimate,namesAndOrientAll(:,1));
    end
    namesAndOrientAll_ultimate=[namesAndOrientAll_ultimate; namesAndOrientAll];
    for cat_no=1:16
        for row_no=1:2
            predAndDirCell_ultimate{row_no,cat_no}=[predAndDirCell_ultimate{row_no,cat_no} predAndDirCell{row_no,cat_no}];
        end
    end
end

predAndDirCell=predAndDirCell_ultimate;
namesAndOrientAll=namesAndOrientAll_ultimate;

save('predAndFileNamesCompiled_ultimate.mat','predAndDirCell','namesAndOrientAll');

