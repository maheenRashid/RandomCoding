ccc
addpath(fullfile('..','..','svm_files'));
load('l#living_room#sun_aykkdobyhjevkiib.mat')
prct_vec=1;
valid_data_size=0.05;
[record_lists_all]=getSeqOptPerformance(record_lists,prct_vec,valid_data_size,1);
save('bug_fix_test.mat');
rmpath(fullfile('..','..','svm_files'));
