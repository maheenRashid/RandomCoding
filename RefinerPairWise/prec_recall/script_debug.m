
ccc

%get problem dirs
in_dir_parent='/lustre/maheenr/3dgp_results/swap_in_box_auto_new_listsScores_1_html/';
in_dir_pre='results_linReg_LOO_ratioEqual_by_prec_withCat_noOrder_*';

del_pre='testTrainData_LOO_ratioEqual_by_prec_withCat_noOrder_';

in_dir=dir(fullfile(in_dir_parent,in_dir_pre));
in_dir={in_dir(:).name};
problem_dirs=cell(1,0);
for i=1:numel(in_dir)
    i
    in_dir_parent_curr=fullfile(in_dir_parent,in_dir{i});
    
    in_dir_number=regexpi(in_dir{i},'_','split');
    in_dir_number=in_dir_number{end};
    
    in_dir_curr=dir(in_dir_parent_curr);
    in_dir_curr=in_dir_curr(3:end);
    in_dir_bin=[in_dir_curr(:).isdir];
    in_dir_curr={in_dir_curr(:).name};
    
    in_dir_curr=in_dir_curr(in_dir_bin);
    
    in_dir_mat=dir(fullfile(in_dir_parent_curr,'*.mat'));
    in_dir_mat={in_dir_mat(:).name};
    in_dir_mat=cellfun(@(x) x(1:end-4),in_dir_mat,'UniformOutput',0);
    
    [~,good_idx]=intersect(in_dir_curr,in_dir_mat);
    problem_cases=in_dir_curr;
    problem_cases(good_idx)=[];
    fprintf('%d\n',numel(problem_cases));

    del_dir_curr=fullfile(in_dir_parent,[del_pre in_dir_number]);
    del_dir_curr
    numel(problem_cases)
    
%     for del_no=1:numel(problem_cases)
%         fprintf('%d of %d\n',del_no,numel(problem_cases));
%         fullfile(in_dir_parent_curr,problem_cases{del_no})
%         fullfile(del_dir_curr,problem_cases{del_no})
%         fullfile(del_dir_curr,[problem_cases{del_no} '.mat'])
%         
%         rmdir(fullfile(in_dir_parent_curr,problem_cases{del_no}));
%         rmdir(fullfile(del_dir_curr,problem_cases{del_no}));
%         delete(fullfile(del_dir_curr,[problem_cases{del_no} '.mat']));
%     end
    
%     keyboard;
end














return


ccc
load('debug.mat','feature_vecs_all','det_scores_all');

feature_vecs_all=feature_vecs_all(1:16);
test_idx=14;
% return
[train_data,test_data]=getTrainTestDataWhitened(feature_vecs_all,...
    det_scores_all,1,[1:(test_idx-1),(test_idx+1):numel(feature_vecs_all)]);




return
dir_parent='/lustre/maheenr/3dgp_results';
folder='swap_in_box_auto_new_listsScores_1';
rec_path='/lustre/maheenr/new_3dgp/indoorunderstanding_3dgp-master';


feature_pre='record_lists_feature_vecs_withCat';
prctile_pre='by_prec_withCat_noOrder';
prctile_temp='by_prec_withCat';
prctile_inc=0.1;




in_dir=[folder '_html'];

%create percentile strings and in out dirs
feature_dir=fullfile(dir_parent,in_dir,feature_pre);

out_dir=fullfile(dir_parent,in_dir,'record_threshes_by_prec');
fprintf('%s\n','getting thresholds by prec');
load (fullfile(rec_path,'record_dpm_new.mat'));
% script_getThresholds;

out_dir_cheat=fullfile(dir_parent,'swap_in_box_auto_listsScores_1_html','record_threshes_by_prec')

out_dir=fullfile(dir_parent,in_dir,'record_threshes_by_prec');

load(fullfile(out_dir_cheat,'record_threshes.mat'),'record_threshes');
prctile_vec=record_threshes.prct_vec;
threshes=record_threshes.threshes_aft;

prctile_str=cellfun(@num2str,num2cell(prctile_vec),'UniformOutput',0);
temp=prctile_str;
prctile_str=cellfun(@(x) [prctile_pre '_' x],prctile_str,'UniformOutput',0);
prctile_str_temp=cellfun(@(x) [prctile_temp '_' x],temp,'UniformOutput',0);

fprintf('%s\n','getting thresholded feature vecs');
% script_getThresholdedFeatureVecs;
% return


compiled_dirs=cell(1,numel(prctile_str));
%loop over each percentiles features
for feature_no=1:numel(prctile_str)
    fprintf('%s\n',...
        ['save whitened training data ' ...
        prctile_str{feature_no} ' percentile']);
    %         dir_feature_vec=fullfile(dir_parent,in_dir,...
    %             [feature_pre '_' prctile_str_temp{feature_no}]);
    dir_feature_vec=fullfile(dir_parent,in_dir,...
        [feature_pre '_' prctile_str{feature_no}]);
    
    out_dir=fullfile(dir_parent,in_dir,...
        ['testTrainData_LOO_ratioEqual_' prctile_str{feature_no}]);
%     keyboard;
    fprintf('by fold\n');
    script_saveTestTrainData_LOO_new_byFold;
%     return
%     script_saveTestTrainData_LOO_new_unitLength;
%     return
%     fprintf('by model\n');
%     script_saveTestTrainData_LOO_new;
%     
%     fprintf('%s\n',...
%         ['do linReg ' prctile_str{feature_no} ' percentile']);
%     dir_nn_loo=out_dir;
%     out_dir=fullfile(dir_parent,in_dir,...
%         ['results_linReg_LOO_ratioEqual_' prctile_str{feature_no}]);
    %     script_linReg_ratioEqual_prec_recall;
    
    
%     fprintf('%s\n',...
%         ['get dpm accu ' prctile_str{feature_no} ' percentile']);
%     dir_result=out_dir;
%     out_dir=fullfile(dir_parent,in_dir,...
%         ['dpm_accu_per_mod_linReg_' prctile_str{feature_no}]);
    
    
    %     load (fullfile(rec_path,'record_dpm_new.mat'));
    
    %     script_saveDPMAccu_prec_recall;
    
%     fprintf('%s\n',...
%         ['compile prec recall ' prctile_str{feature_no} ' percentile']);
%     dir_dpm_accu=out_dir;
%     out_dir=fullfile(dir_parent,in_dir,...
%         ['dpm_accu_compiled_linReg_' prctile_str{feature_no}]);
    %     script_compileDPMAccu_prec_recall;
    
%     compiled_dirs{feature_no}=out_dir;
    %         return
end

%     fprintf('%s\n','create prec recall curves');
%     out_dir=fullfile(dir_parent,in_dir,...
%         ['prec_recall_curves_mat_images_' prctile_pre]);
%     script_savePrecRecallCompiledMatAndImages;


