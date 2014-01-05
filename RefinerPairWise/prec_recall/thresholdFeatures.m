function [features_aft,idx_prob]=thresholdFeatures(features,thresh)
% features=cellfun(@(x) x(2:end),features,'UniformOutput',0);
idx_prob=cellfun(@(x) sum(x(2:end)>=thresh),features);
idx_pos=cellfun(@(x) sum(x(2:end)>0),features);
idx_prob=idx_prob == idx_pos;
features_aft=features(idx_prob>=1);
end