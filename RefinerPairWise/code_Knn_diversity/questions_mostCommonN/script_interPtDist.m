ccc

in_dir='testTrainData_LOO_ratioEqual_by_prec_withCat_0.10109_diversity_1';

models=dir(fullfile(in_dir,'*.mat'));

load(fullfile(in_dir,models(1).name),'record_lists');

train_data=record_lists.train_data.X;
md=train_data(1:20,:);
ld=train_data(end-20:end,:);

md_D = pdist2(md',md','mahalanobis');
ld_D=pdist2(ld',ld','mahalanobis');

figure; imagesc(md_D);title('MD D');
figure; hist(md_D(:))
% mean(md_D(:))
figure;imagesc(ld_D);title('LD D');
figure; hist(ld_D(:))
% max(ld_D(:))

