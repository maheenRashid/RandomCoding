ccc
dir_parent='/lustre/maheenr/results_temp_09_13';
folders={'swapObjectsInBox_allOffsets_sizeComparison_bugFixed_gt_refPW',...
    'swapObjectsInBox_allOffsets_sizeComparison_bugFixed_refPW'};

n=3;

c_out_folder_pre=['swapAllCombos_unique_' num2str(n) '_'];
c_out_folder_post={'gt','auto'};
c_file_to_run='renderLists';

folder_no=1;

folder=folders{folder_no};
c_out_folder_post_curr=c_out_folder_post{folder_no};
nn_folder_meta=['swapAllCombos_unique_' num2str(n) '_' ...
c_out_folder_post{folder_no} '_writeAndScoreLists_html'];
k_vec= 0.01:0.01:0.1;

out_dir='knn_renderLists';
if ~exist(out_dir)
    mkdir(out_dir);
end

mat_files=cell(1,0);
for k_no=k_vec
    file=strrep(folder,'_refPW','');
    load([file '.mat']);
    
    nn_folder_curr=['best_list_' num2str(k_no) '_nn_LOO'];
    out_name=[c_out_folder_pre c_out_folder_post_curr '_nn_' num2str(k_no)];
    
    path_to_text=fullfile(dir_parent,folder,'text_files');
    path_to_bestList=fullfile(dir_parent,nn_folder_meta,nn_folder_curr);
    cellCommands=createRenderListsMat(cellCommands,c_file_to_run,...
        path_to_text,path_to_bestList,out_name,file);
    save(fullfile(out_dir,[out_name '.mat']),'cellCommands');
    mat_files=[mat_files fullfile(out_dir,out_name)];
end
save('folders_for_execute_script.mat','mat_files');
