function [feature_cat_no]=getFeature_CatNo(cat_nos,map)
cat_nos_rep=repmat(cat_nos,1,numel(map));
map_rep=repmat(map,numel(cat_nos),1);
bin=cat_nos_rep==map_rep;
bin=bin';
feature_cat_no=bin(:);

end