function features_aft=thresholdFeatures_temp(features,thresh)
features_nan=features(:,2:end);
features_nan(features_nan==0)=nan;
features_bin=features_nan>=thresh;
idx_prob=sum(features_bin,2);
features_aft=features(idx_prob>=1,:);
end