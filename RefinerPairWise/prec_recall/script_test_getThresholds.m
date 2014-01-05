ccc
load('temp');
load(fullfile('..','record_dpm'),'record_dpm');
feature_names=cellfun(@(x) x{end-1},...
    cellfun(@(x) regexpi(x,'[#.]','split'),features_mat,'UniformOutput',0)...
    ,'UniformOutput',0);
dpm_names={record_dpm(:).id};
[common,idx_feature,idx_dpm]=intersect(feature_names,dpm_names);
record_dpm_p=record_dpm(idx_dpm);


%get dpm scores
dpm_scores={record_dpm_p(:).boxes};
dpm_scores=cellfun(@(x) x(:,end),dpm_scores,'UniformOutput',0);
dpm_bin={record_dpm_p(:).obj_map};
total_gt={record_dpm_p(:).total_gt};

%go over all the unique scores as thresholds
threshes=cell2mat(dpm_scores');
threshes=sort(unique(threshes));
% threshes=threshes(1:100:end);
[prec_per_thresh,recall_per_thresh,number_per_thresh]=...
    getPrecRecallPerThreshDpm(threshes,dpm_scores,dpm_bin,total_gt);
% threshes=round(100*threshes)/100;
% threshes=unique(threshes); 
% threshes=sort(threshes,'descend');

%calculate recall for each threshold
% recall_per_thresh=zeros(1,numel(threshes));
% prec_per_thresh=zeros(1,numel(threshes));
% number_per_thresh=zeros(1,numel(threshes));
% for thresh_no=1:numel(threshes)
%     ratio_correct=zeros(2,numel(total_gt));
%     ratio_correct(2,:)=cell2mat(total_gt);
%     
%     
%     
%     thresh=threshes(thresh_no);
%     
%     dpm_scores_t=cellfun(@(x) x(x>=thresh),dpm_scores,'UniformOutput',0);
%     dpm_bin_t=cellfun(@(x,y) x(y>=thresh),dpm_bin,dpm_scores,'UniformOutput',0);
%     empty_bin=cellfun(@isempty,dpm_bin_t);
%     ratio_correct(:,empty_bin)=[];
%     
%     dpm_bin_t=dpm_bin_t(~empty_bin);
%     
%     prec_correct=zeros(2,numel(dpm_bin_t));
%     prec_correct(2,:)=cellfun(@numel,dpm_bin_t);
%     prec_correct(1,:)=cellfun(@(x) sum(x>0),dpm_bin_t);
%     
% %     keyboard;
%     for dpm_bin_no=1:numel(dpm_bin_t)
%         curr=dpm_bin_t{dpm_bin_no};
%         curr=unique(curr);
%         curr(curr==0)=[];
%         ratio_correct(1,dpm_bin_no)=numel(curr);
%     end
%     
%     recall_per_thresh(thresh_no)=sum(ratio_correct(1,:))/sum(ratio_correct(2,:));
%     number_per_thresh(thresh_no)=sum(~empty_bin);
%     prec_per_thresh(thresh_no)=sum(prec_correct(1,:))/sum(prec_correct(2,:));
%     
% %     correct_count=
% end
%plot
figure; subplot(221);plot(threshes,recall_per_thresh,'-r','linewidth',2);
subplot(222);plot(threshes,prec_per_thresh,'-g','linewidth',2);
subplot(223);plot(recall_per_thresh,prec_per_thresh,'-m','linewidth',2);
subplot(224);plot(threshes,number_per_thresh,'-b','linewidth',2);

%get the recall for certain recall thresholds
prct_vec=min(prec_per_thresh):0.1:max(prec_per_thresh);
threshes_new=zeros(size(prct_vec));
for prct_no=1:numel(prct_vec)
    prct_curr=prct_vec(prct_no);
    threshes_new(prct_no)=min(threshes(prec_per_thresh>=prct_curr));
end
threshes=threshes_new;

[prec_per_thresh,recall_per_thresh,number_per_thresh]=...
    getPrecRecallPerThreshDpm(threshes,dpm_scores,dpm_bin,total_gt);

figure; subplot(221);plot(threshes,recall_per_thresh,'-r','linewidth',2);
subplot(222);plot(threshes,prec_per_thresh,'-g','linewidth',2);
subplot(223);plot(recall_per_thresh,prec_per_thresh,'-m','linewidth',2);
subplot(224);plot(threshes,number_per_thresh,'-b','linewidth',2);


return
ccc
dir_parent='/lustre/maheenr/results_temp_09_13';
folders={'swapObjectsInBox_allOffsets_sizeComparison_bugFixed_gt_refPW',...
    'swapObjectsInBox_allOffsets_sizeComparison_bugFixed_refPW'};

folder_type={'gt','auto'};

n=3;
folder_no=1;

in_dir=['swapAllCombos_unique_' num2str(n) '_' folder_type{folder_no} ...
        '_writeAndScoreLists_html'];
    
    %create percentile strings and in out dirs
    feature_dir=fullfile(dir_parent,in_dir,'record_lists_feature_vecs');
    

features_mat=dir(fullfile(feature_dir,'*.mat'));
features_mat={features_mat(:).name};
save('temp.mat','features_mat');

return
dpm_scores_all=cell(numel(features_mat),1);
for mat_no=1:numel(features_mat)
    temp=load(fullfile(feature_dir,features_mat{mat_no}));
    record_lists=temp.record_lists;
    dpm_scores_all{mat_no}=record_lists.dpm_scores;
end

dpm_scores_all=cell2mat(dpm_scores_all);

%get thresholds and prctile str
threshes=prctile(dpm_scores_all,prctile_vec);
%add one for thresholding feature vecs
threshes=threshes+1;