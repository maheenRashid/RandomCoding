ccc

dir_parent='/lustre/maheenr/results_temp_09_13';
in_dir='swapAllCombos_unique_3_gt_writeAndScoreLists_html';
out_dir_pre='testTrainData_LOO_ratioEqual_by_prec_withCat_0.10109';
feature_dir=fullfile(dir_parent,in_dir,out_dir_pre);

fold_no=1;
valid_percentage=0.05;
test_size=1/5;

models=dir(fullfile(feature_dir,'*.mat'));
models={models(:).name};

temp=load(fullfile(feature_dir,models{1}));
models=temp.record_lists.models_curr;

total=numel(models);
valid_no=floor(total*valid_percentage);
total=total-valid_no;
test_no=ceil(total*test_size);
train_no=total-test_no;

rand_idx=randperm(numel(models));
valid_idx=rand_idx(1:valid_no);
test_idx=rand_idx(valid_no+1:valid_no+test_no);
train_idx=rand_idx(valid_no+test_no+1:valid_no+test_no+train_no);

%create a folder with this new data

out_dir_meta=fullfile(dir_parent,'diversity_question');
out_dir=fullfile(out_dir_meta,'testTrainData_LOO_ratioEqual_by_prec_withCat_0.10109');
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end

for i=1:numel(test_idx)
    temp=load(fullfile(feature_dir,models{test_idx(i)}));
    record_lists=temp.record_lists;
    record_lists.train_idx=train_idx;
    record_lists.valid_idx=valid_idx;
    record_lists.test_idx=test_idx(i);
    save(fullfile(out_dir,[models{test_idx(i)} '.mat']));
end
