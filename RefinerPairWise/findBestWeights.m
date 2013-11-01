function [cost]=findBestWeights(weights,scores,gts)
    cost=weights'*scores;
    cost=cost-gts;
    cost=abs(cost);
    cost=sum(cost);

end