
% folder='../swapObjectsInBox_allOffsets_new';
%folder='../swapObjectsInBox_allOffsets_new';
folder='../swapObjectsInBox_allOffsets_sizeComparison_bugFixed_gt';

dir_all=dir(folder);
dir_all=dir_all(3:end);
names_and_scores=cell(4,numel(dir_all));
for dir_no=1:numel(dir_all)

fid=fopen(fullfile(folder,dir_all(dir_no).name,'scores_and_offsets.txt'));
data=textscan(fid,'%s','delimiter','\n');
fclose(fid);
data=data{1};
if numel(data)<5
    continue
end
temp=data([2:3,end-1:end]);
scores=zeros(2,6);
for i=1:2:numel(temp)
    temp_split=regexpi(temp{i},' ','split');
    scores((i+1)/2,1)=str2num(temp_split{end});
    temp_split=regexpi(temp{i+1},' ','split');
    idx=strcmp('GT_SCORE_all_px',temp_split);
    idx=find(idx);
    idx=idx+1;
    scores((i+1)/2,2:end)=cellfun(@str2num,temp_split(idx:2:end));
end

names_and_scores{1,dir_no}=dir_all(dir_no).name;
names_and_scores{2,dir_no}=scores;
names_and_scores{3,dir_no}='orig_with_cube_';
names_and_scores{4,dir_no}='final_with_cube_';
end
save('names_and_scores.mat','names_and_scores');

% [max_val,max_idx]=max(pred_scores)
% gt_line_max=data{2*max_idx+3};
% temp=regexpi(gt_line_max,' ','split');
% im_pre_max=['each_rep_' temp{4} '_' temp{6} '_' temp{8}(1:end-1) '_'];
