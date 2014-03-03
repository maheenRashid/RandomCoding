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
k_vec=[0.01:0.01:0.1,0.2:0.1:1];
% k_vec=nan(1);

for folder_no=1
    %     :numel(folders)
    folder=folders{folder_no};
    in_dir_old=['swapAllCombos_unique_' num2str(n) '_' folder_type{folder_no} ...
        '_writeAndScoreLists_html'];
    
    in_dir='diversity_question';

    dir_in_meta=fullfile(dir_parent,in_dir);
    
    dir_in_meta_f=fullfile(dir_parent,in_dir_old);
    feature_dir=fullfile(dir_in_meta_f,feature_pre);
    
    %create percentile strings and in out dirs
%     feature_dir=fullfile(dir_in_meta,feature_pre);
%     load(fullfile(dir_in_meta,...
%         'record_threshes_by_prec','record_threshes.mat'),'record_threshes');
%     prctile_vec=record_threshes.prct_vec;
%     threshes=record_threshes.threshes_aft;
%     
    
    %diversity specific
    prctile_vec=0.10109;
    
    %if you want to switch to no diversity, uncomment
    prctile_str=cellfun(@num2str,num2cell(prctile_vec),'UniformOutput',0);
%     prctile_str_feat=cellfun(@(x) [prctile_pre_feature '_' x]...
%         ,prctile_str,'UniformOutput',0);
    prctile_str=cellfun(@(x) [prctile_pre '_' x],prctile_str,'UniformOutput',0);
    
    
    %diversity specific
    div_prct_vec=0.05:0.05:1;
    div_prct_str=cellfun(@num2str,num2cell(div_prct_vec),'UniformOutput',0);
    
    temp=[prctile_str{1}];
    prctile_str_feat=cell(size(div_prct_str));
    [prctile_str_feat{:}]=deal(temp);
    
    prctile_str=cellfun(@(x) [prctile_str{1} '_diversity_' x],div_prct_str,...
                'UniformOutput',0);
    
    k_vec=k_vec(randperm(numel(k_vec)));
%     return
    for k=k_vec
        dir_in_k=fullfile(dir_in_meta,['KNN_' num2str(k) '_LOO_ratioEqual']);
        
        if ~exist(dir_in_k,'dir')
            mkdir(dir_in_k);
        end
%         
%         dir_mutex=['dummy_' num2str(k)];
%         if ~exist(dir_mutex,'dir');
%             mkdir(dir_mutex);
%         else
%             continue;
%         end
        
        compiled_dirs=cell(1,numel(prctile_str));
        
        %loop over each percentiles features
        for feature_no=1:numel(prctile_str)
            
            if isnan(k)
                fprintf('%s\n',...
                    ['do knn k ' num2str(k) ' ' prctile_str{feature_no} ' percentile']);
                dir_in=fullfile(dir_in_meta,...
                    ['testTrainData_LOO_ratioEqual_' prctile_str{feature_no}]);
                out_dir=fullfile(dir_in_k,...
                    ['results_' prctile_str{feature_no}]);
                if ~exist(['dummy_' prctile_str{feature_no}],'dir')
                    mkdir(['dummy_' prctile_str{feature_no}]);
                else
                    continue;
                end
                script_knn_ratioEqual_prec_recall;
                
            else
                fprintf('%s\n',...
                    ['do knn k ' num2str(k) ' ' prctile_str{feature_no} ' percentile']);
                dir_in=fullfile(dir_in_meta,...
                    ['KNN_' num2str(nan) '_LOO_ratioEqual'],...
                    ['results_' prctile_str{feature_no}]);
                out_dir=fullfile(dir_in_k,...
                    ['results_' prctile_str{feature_no}]);
                
%                 if ~exist([out_dir '_dummy'],'dir')
%                     mkdir([out_dir '_dummy']);
%                 else
%                     continue;
%                 end

                
%                 script_knn_ratioEqual_prec_recall;

                fprintf('%s\n',...
                    ['get dpm accu ' prctile_str{feature_no} ' percentile']);
%                 dir_feature_vec=fullfile(dir_in_meta,...
%                 [feature_pre '_' prctile_str_feat{feature_no}]);
                
                dir_feature_vec=fullfile(dir_in_meta_f,...
                [feature_pre '_' prctile_str_feat{feature_no}]);


                dir_result=out_dir;
                out_dir=fullfile(dir_in_k,...
                    ['dpm_accu_per_mod' prctile_str{feature_no}]);
%                 script_saveDPMAccu_prec_recall;
                
                fprintf('%s\n',...
                    ['compile prec recall ' prctile_str{feature_no} ' percentile']);
                dir_dpm_accu=out_dir;
                out_dir=fullfile(dir_in_k,...
                    ['dpm_accu_compiled_' prctile_str{feature_no}]);
%                 script_compileDPMAccu_prec_recall;
                
                compiled_dirs{feature_no}=out_dir;
            end
            
        end
        
        if ~isempty(compiled_dirs{1})
            fprintf('%s\n','create prec recall curves');
            out_dir=fullfile(dir_in_k,...
                ['prec_recall_curves_mat_images_' prctile_pre '_diversity']);
            script_savePrecRecallCompiledMatAndImages;
        end
        
    end
    
end
