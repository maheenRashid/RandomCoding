ccc

dir_parent='/lustre/maheenr/results_temp_09_13';
folders={'swapObjectsInBox_allOffsets_sizeComparison_bugFixed_gt_refPW',...
    'swapObjectsInBox_allOffsets_sizeComparison_bugFixed_refPW'};

n=3;

c_out_folder_pre=['swapAllCombos_unique_' num2str(n)];
c_out_folder_post={'_gt_writeFloorOverlap','_auto_writeFloorOverlap'};
c_file_to_run='writeFloorOverlap';

for folder_no=1:numel(folders)
folder=folders{folder_no};
c_out_folder_post_curr=c_out_folder_post{folder_no};
% fprintf('%s\n','writing top n record mat files');
% script_pruneAllBoxesInfo_Unique;

fprintf('%s\n','writing top n record text files');
script_writeTextFiles;
fprintf('%s\n','writing cellcommand for floorOverlap');
script_createFloorOverlapMat;

save('folders_for_execute_script.mat','mat_files');

% curr_folder=pwd();
% script_name='executeScript.m';
% 
% fprintf('%s\n','done with stage_1');
% fprintf('\n');
% fprintf('%s\n',['cd ' curr_folder ';nohup matlab <' script_name '> /dev/null 2>&1&']);
end
