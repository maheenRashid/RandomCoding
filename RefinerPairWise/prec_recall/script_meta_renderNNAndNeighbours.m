ccc

dir_parent='/lustre/maheenr/results_temp_09_13';
folders={'swapObjectsInBox_allOffsets_sizeComparison_bugFixed_gt_refPW',...
    'swapObjectsInBox_allOffsets_sizeComparison_bugFixed_refPW'};

folder_type={'gt','auto'};

n=3;

feature_pre='record_lists_feature_vecs_withCat';
% prctile_pre='by_prec_withCat_noOrder';
prctile_pre='by_prec_withCat';
prctile_pre_feature='by_prec_withCat';

prctile_inc=0.1;
k_vec=0.01;
% :0.01:0.09;
v_no=5;

path_to_cellCommands=cell(1,0);
path_to_cellCommands_neighbours=cell(1,0);


for folder_no=1
    %     :numel(folders)
    folder=folders{folder_no};
    in_dir_old=['swapAllCombos_unique_' num2str(n) '_' folder_type{folder_no} ...
        '_writeAndScoreLists_html'];

    in_dir='diversity_question';
    dir_in_meta=fullfile(dir_parent,in_dir_old);
    
    %create percentile strings and in out dirs
    feature_dir=fullfile(dir_in_meta,feature_pre);
    load(fullfile(dir_in_meta,...
        'record_threshes_by_prec','record_threshes.mat'),'record_threshes');
    prctile_vec=record_threshes.prct_vec;
    threshes=record_threshes.threshes_aft;
    
    prctile_vec=0.10109;

    %if you want to switch to no diversity, uncomment
    prctile_str=cellfun(@num2str,num2cell(prctile_vec),'UniformOutput',0);
%     prctile_str_feat=cellfun(@(x) [prctile_pre_feature '_' x]...
%         ,prctile_str,'UniformOutput',0);
    prctile_str=cellfun(@(x) [prctile_pre '_' x],prctile_str,'UniformOutput',0);
    
    
    %diversity specific
    div_prct_vec=[0.05,0.5,1];
    div_prct_str=cellfun(@num2str,num2cell(div_prct_vec),'UniformOutput',0);
    
    temp=[prctile_str{1}];
    prctile_str_feat=cell(size(div_prct_str));
    [prctile_str_feat{:}]=deal(temp);
    
    prctile_str=cellfun(@(x) [prctile_str{1} '_diversity_' x],div_prct_str,...
                'UniformOutput',0);

    for k=k_vec
        dir_in_k=fullfile(dir_parent,in_dir,['KNN_' num2str(k) '_LOO_ratioEqual']);
        
        if ~exist(dir_in_k,'dir')
            mkdir(dir_in_k);
        end
        
        compiled_dirs=cell(1,numel(prctile_str));
        
        %loop over each percentiles features
        for feature_no=1:numel(prctile_str)
            
            out_dir_mats=fullfile(dir_in_k,['mats_for_rendering_' prctile_str{feature_no}]);
            if ~exist(out_dir_mats,'dir')
                mkdir(out_dir_mats);
            end
            
            dir_lists=fullfile(dir_in_meta,'record_lists');
            dir_results=fullfile(dir_in_k,...
                ['results_' prctile_str{feature_no}]);
            
            out_dir=fullfile(dir_in_k,['best_list_text_' prctile_str{feature_no}]);
            [record_path_nn_text]=writeBestListText(dir_lists,dir_results,out_dir);
            save(fullfile(out_dir_mats,'record_best_list_path.mat'),'record_path_nn_text');
            
%             load(fullfile(out_dir_mats,'record_best_list_path.mat'),'record_path_nn_text');
            load([folder_type{folder_no} '_cellCommands_struct.mat']);
            
            path_to_bestList=out_dir;
            out_dir_rendering=['K_' num2str(k) '_' prctile_str{feature_no} '_question'];
            cellCommands=createRenderListsMat(params, path_to_bestList, out_dir_rendering);
            mat_file=fullfile(out_dir_mats,out_dir_rendering);
            save([mat_file '.mat'],'cellCommands');
            path_to_cellCommands=[path_to_cellCommands mat_file];
            
            out_dir_neighbours=[out_dir '_neigbours'];
            [record_path_nn_text]=writeBestListText(dir_lists,dir_results,out_dir_neighbours,1,v_no,k);
            save(fullfile(out_dir_mats,'record_best_list_path_neighbours.mat'),'record_path_nn_text');
              
              out_dir_rendering_neighbours=[out_dir_rendering '_neighbours'];
               [ cellCommands ] = createCellCommands_neighbours( record_path_nn_text,params,out_dir_rendering_neighbours);
               mat_file=fullfile(out_dir_mats,out_dir_rendering_neighbours);
            save([mat_file '.mat'],'cellCommands');
            path_to_cellCommands_neighbours=[path_to_cellCommands_neighbours mat_file];
            
        end
    end
%     save('path_to_cellCommands_best_list.mat','path_to_cellCommands');
%     save('path_to_cellCommands_best_list_neighbours.mat','path_to_cellCommands_neighbours');

    save('path_to_cellCommands_best_list_diversity.mat','path_to_cellCommands');
    save('path_to_cellCommands_best_list_neighbours_diversity.mat','path_to_cellCommands_neighbours');
end
