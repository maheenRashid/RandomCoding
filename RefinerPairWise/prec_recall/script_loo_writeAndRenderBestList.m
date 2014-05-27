ccc


rec_path='/lustre/maheenr/new_3dgp/indoorunderstanding_3dgp-master';


dir_parent='/lustre/maheenr/3dgp_results';
folders={'swap_in_box_auto_listsScores_1'};

% dir_parent='/lustre/maheenr/cube_per_cam_regenerate/room3D_gt';
% folders={'swap_in_box_auto_listsScores_1'};


feature_pre='record_lists_feature_vecs_withCat';
prctile_pre='by_prec_withCat_noOrder';
prctile_temp='by_prec_withCat';
prctile_inc=0.1;

result_pre='results_linReg_LOO_ratioEqual_test_';

dir_parent_org='/lustre/maheenr/3dgp_results';
out_dir_cheat=fullfile(dir_parent_org,'swap_in_box_auto_listsScores_1_html','record_threshes_by_prec')

for folder_no=1
%         :numel(folders)
    folder=folders{folder_no};
    in_dir=[folder '_rerun_html'];
     in_dir_cheat=[folder '_html'];
%     in_dir='processing_lists';
    
    %create percentile strings and in out dirs
    feature_dir=fullfile(dir_parent,in_dir,feature_pre);
    
    out_dir=fullfile(dir_parent,in_dir,'record_threshes_by_prec');
    fprintf('%s\n','getting thresholds by prec');
    
    load(fullfile(out_dir_cheat,'record_threshes.mat'),'record_threshes');
    prctile_vec=record_threshes.prct_vec;
    threshes=record_threshes.threshes_aft;
    
    prctile_str=cellfun(@num2str,num2cell(prctile_vec),'UniformOutput',0);
    temp=prctile_str;
    prctile_str=cellfun(@(x) [prctile_pre '_' x],prctile_str,'UniformOutput',0);
    prctile_str_temp=cellfun(@(x) [prctile_temp '_' x],temp,'UniformOutput',0);
    
%     out_dir_mats=fullfile(dir_parent,in_dir,'best_lists_mat');
%     if ~exist(out_dir_mats,'dir')
%         mkdir(out_dir_mats);
%     end
%     
    for feature_no=1
%         2:numel(prctile_str)
        dir_lists=fullfile(dir_parent,in_dir_cheat,'record_lists');
        out_dir=fullfile(dir_parent,in_dir,['best_list_text_' prctile_str{feature_no}]);
        dir_results=fullfile(dir_parent,in_dir,[result_pre prctile_str{feature_no}]);
        if ~exist(out_dir,'dir')
            mkdir(out_dir);
        end
        [record_path_nn_text]=writeBestListText(dir_lists,dir_results,out_dir);
%         save(fullfile(out_dir_mats,['record_best_list_path_' prctile_str{feature_no} '.mat']),'record_path_nn_text');
    end
end
