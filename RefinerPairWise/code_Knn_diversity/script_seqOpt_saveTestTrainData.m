ccc

dir_parent='/lustre/maheenr/results_temp_09_13';
folders={'swapObjectsInBox_allOffsets_sizeComparison_bugFixed_gt_refPW',...
    'swapObjectsInBox_allOffsets_sizeComparison_bugFixed_refPW'};

folder_type={'gt','auto'};

n=3;
folder_no=1;
folder=folders{folder_no};
% in_dir=['swapAllCombos_unique_' num2str(n) '_' folder_type{folder_no} ...
%     '_writeAndScoreLists_html'];

in_dir='diversity_question';

%create percentile strings and in out dirs
out_dir_pre='testTrainData_LOO_ratioEqual';
prctile_str='_by_prec_withCat_0.10109';
feature_dir=fullfile(dir_parent,in_dir,[out_dir_pre prctile_str]);

files=dir(fullfile(feature_dir,'*.mat'));
files={files(:).name};

prct_vec=0.05:0.05:1;
% valid_data_size=0.05;
valid_data_size=-1;

div_prct_str=cellfun(@num2str,num2cell(prct_vec),'UniformOutput',0);
div_prct_str=cellfun(@(x) [prctile_str '_diversity_' x],div_prct_str,...
                'UniformOutput',0);

out_dir_record=cell(1,numel(prct_vec));
for prct_no=1:numel(prct_vec)
    out_dir=fullfile(dir_parent,in_dir,[out_dir_pre,div_prct_str{prct_no}]);
    if ~exist(out_dir,'dir')
        mkdir(out_dir);
    end
    out_dir_record{prct_no}=out_dir;
end


addpath(fullfile('..','..','svm_files'));
% matlabpool open
% par
for file_no=1:numel(files)
    out_dir_name=fullfile(out_dir_record{1},files{file_no}(1:end-4));
    if ~exist(out_dir_name,'dir')
        mkdir(out_dir_name);
    else
        
%         fprintf('i should have continued');
        continue;
    end
%     tic()
    file_no
    temp=load(fullfile(feature_dir,files{file_no}));
    record_lists=temp.record_lists;
    
    [record_lists_all]=...
        getSeqOptPerformance(record_lists,prct_vec,valid_data_size,1);
    for rec_no=1:numel(record_lists_all)
        out_file_name=fullfile(out_dir_record{rec_no},files{file_no});
        parsave(out_file_name,record_lists_all{rec_no});
    end
%     toc()
end
% matlabpool close
rmpath(fullfile('..','..','svm_files'));
