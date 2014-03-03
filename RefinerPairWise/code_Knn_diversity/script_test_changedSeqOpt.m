ccc
addpath ('../prec_recall/');
addpath(fullfile('..','..','svm_files'));

load('l#living_room#sun_aykkdobyhjevkiib.mat')


prct_vec=0.05:0.05:1;
valid_data_size=0.05;

record_lists.train_idx=record_lists.train_idx(1:11:end);
% record_lists.train_data.y=record_lists.train_data.y(1:100:size(train_data.X,1),:);

record_to_return=getSeqOptPerformance(record_lists,prct_vec,valid_data_size,1)

