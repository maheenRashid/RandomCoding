ccc

dir_parent='/home/maheenr/3dgp_results';
folder='swap_in_box_auto_new_listsScores_1';

folder_lists='swap_in_box_auto_new_listScores_1';
folder_other='swap_in_box_auto_new_floorOverlap_1';


dir_parent='/lustre/maheenr/cube_per_cam_regenerate/room3D_gt';
% folder='swapAllCombos_unique_10_gt_writeAndScoreLists';
folder='lists_scores';

folder_lists='lists_scores';
folder_other='floorOverlap';



out_dir=fullfile(dir_parent,[folder '_html'],'record_lists');
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end

ids=dir(fullfile(dir_parent,folder_lists));
ids=ids(3:end);
ids={ids(:).name};

% matlabpool open;
% par
for model_no=1:numel(ids)
    
    id_curr=ids{model_no};
    fprintf('model_no: %s %d\n',id_curr,model_no);
    
    out_file_name=fullfile(out_dir,[id_curr '.mat']);
%     out_mutex=fullfile(out_dir,id_curr);
%     if ~exist(out_mutex,'dir')
%         mkdir(out_mutex);
%     else
%         continue;
%     end
    
%     try
        fname_lists=fullfile(dir_parent,folder_lists,id_curr,'scores_and_offsets.txt');
        fname_other=fullfile(dir_parent,folder_other,id_curr,'lists_and_scores.txt');
        record_lists=getOtherInfoFromFile(fname_other);
        [scores,lists,gt_scores]=getListInfoFromFile(fname_lists);
        record_lists.scores=scores;
        record_lists.lists=lists;
        record_lists.gt_scores=gt_scores;
        keyboard;
        %         parsave(out_file_name,record_lists);
%     catch err
%         fprintf('error!\n');
%         if exist(out_file_name,'file')
%             delete(out_file_name);
%         end
%         %         fprintf('error\n');
%         %         errors(model_no).error=err;
%     end
%     %     return
end
% matlabpool close
% save('reread_lists.mat','errors','ids','folder_lists','folder_other');
% sum(new_count)




