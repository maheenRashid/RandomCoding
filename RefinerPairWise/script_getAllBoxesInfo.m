ccc

% dir_parent='/lustre/maheenr/results_temp_09_13';
% 
% folders={'swapObjectsInBox_allOffsets_sizeComparison_bugFixed_gt','swapObjectsInBox_allOffsets_sizeComparison_bugFixed'};



dir_parent='/lustre/maheenr/3dgp_results';
load('problem_case_to_repeat.mat');

% folders={'swap_in_box_auto'};
folders={'swap_in_box_auto_new'};

for folder_no=1:numel(folders)
    folder=folders{folder_no};
    out_dir=fullfile(dir_parent,[folder '_refPW']);
if ~exist(out_dir)
    mkdir(out_dir);
end

names=dir(fullfile(dir_parent,folder));
names={names(3:end).name};
bin_exclude=strcmp(str,names);
names=names(~bin_exclude);

temp=cell(numel(names),1);
record_box_info_all=struct('id',temp,'box_ids',temp,'swap_info',temp,'pred_scores',temp,'gt_scores',temp);

errorLog=cell(1,0);
matlabpool open;
parfor i=1:numel(names)
    i    
    try
        fid=fopen(fullfile(dir_parent,folder,names{i},'scores_and_offsets.txt'));
        data=textscan(fid,'%s','delimiter','\n');
        fclose(fid);
        data=data{1};
        [box_ids,swap_info,pred_scores,gt_scores]=getSwapAndScoreInfoAll(data);
        record_box_info_all(i).id=names{i};
        record_box_info_all(i).box_ids=box_ids;
        record_box_info_all(i).swap_info=swap_info;
        record_box_info_all(i).pred_scores=pred_scores;
        record_box_info_all(i).gt_scores=gt_scores;
    catch err
        disp('error!');
        
        names{i}
    end
    
end
matlabpool close;

idx=find(cellfun(@isempty,{record_box_info_all(:).id}));
record_box_info_all(idx)=[];

save(fullfile(out_dir,'record_box_info_all.mat'),'record_box_info_all');


end
