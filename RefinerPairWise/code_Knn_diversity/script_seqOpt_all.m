ccc

dir_parent='/lustre/maheenr/results_temp_09_13';
folders={'swapObjectsInBox_allOffsets_sizeComparison_bugFixed_gt_refPW',...
    'swapObjectsInBox_allOffsets_sizeComparison_bugFixed_refPW'};

folder_type={'gt','auto'};

n=3;
folder_no=1;
folder=folders{folder_no};
in_dir=['swapAllCombos_unique_' num2str(n) '_' folder_type{folder_no} ...
    '_writeAndScoreLists_html'];

%create percentile strings and in out dirs
feature_dir=fullfile(dir_parent,in_dir,'testTrainData_LOO_ratioEqual');

files=dir(fullfile(feature_dir,'*.mat'));
files={files(:).name};
out_dir=fullfile(dir_parent,in_dir,'diversity_record');

if ~exist(out_dir,'dir')
    mkdir(out_dir);
end

prct_vec=0.05:0.05:1;
valid_data_size=0.05;

perf_seq_opt_all=zeros(numel(files),numel(prct_vec));
perf_rand_all=zeros(numel(files),numel(prct_vec));

addpath(fullfile('..','..','svm_files'));
matlabpool open
parfor file_no=1:numel(files)
    file_no
    temp=load(fullfile(feature_dir,files{file_no}));
    record_lists=temp.record_lists;
    
%     [perf_seq_opt,dist_seq_opt,perf_rand,dist_rand]=...
%     getSeqOptPerformance(record_lists,prct_vec,valid_data_size);
    
    [record_performance]=getSeqOptPerformance(record_lists,prct_vec,valid_data_size);

    
    perf_seq_opt_all(file_no,:)=perf_seq_opt;
    perf_rand_all(file_no,:)=perf_rand;
    
%     record_performance=struct();
%     record_performance.perf_seq_opt=perf_seq_opt;
%     record_performance.dist_seq_opt=dist_seq_opt;
%     record_performance.dist_rand=dist_rand;
%     record_performance.perf_rand=perf_rand;
%     record_performance.valid_data_size=valid_data_size;
%     record_performance.prct_vec=prct_vec;
    
    out_file_name=fullfile(out_dir,files{file_no});
    parsave(out_file_name,record_performance);
end
matlabpool close
rmpath(fullfile('..','..','svm_files'));
save(fullfile(out_dir,'perf_all.mat'),'perf_seq_opt_all','perf_rand_all');