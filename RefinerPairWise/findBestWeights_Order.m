function [cost]=findBestWeights_Order(weights,scores,gts)
    cost=weights'*scores;
    [~,cost]=sort(cost,'descend');
    cost=cost-gts;
    cost=abs(cost);
    cost=sum(cost)

end