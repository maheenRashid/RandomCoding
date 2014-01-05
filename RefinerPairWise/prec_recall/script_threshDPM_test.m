ccc
load('b#bedroom#sun_aaajwnfblludyasb');
features_all=record_lists.feature_vecs_all;
vec_all=zeros(0,1);
for i=1:numel(features_all)
    temp=features_all{i};
    temp=temp(:,2:end);
    vec_all=[vec_all;temp(:)];
end

%get threshes
vec_all(vec_all==0)=[];
threshes=prctile(vec_all,0:10:100);

%goes between -1 and max of dpm.
% threshes=ptile;
counts=zeros(size(threshes));

% thresh= 0.5;
for thresh_no=1:numel(threshes)
    thresh=threshes(thresh_no);
    count_aft=0;
    for i=1:numel(features_all)
        features_all{i}=thresholdFeatures(features_all{i},thresh);
        count_aft=count_aft+size(features_all{i},1);
    end
    counts(thresh_no)=count_aft;
end