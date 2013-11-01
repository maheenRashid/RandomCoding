function h=plotFeatures(features,class_train,h)
    if nargin<3
        h=figure;
    else
        figure(h);
    end
    
    features_r=features(class_train==0,:);
    features_b=features(class_train==1,:);
    
    hold on;
    plot(features_r(:,1),features_r(:,2),'*r');
    plot(features_b(:,1),features_b(:,2),'*b');
        
    
end