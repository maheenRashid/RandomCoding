%concatenating features


ccc
addpath ..

load l#living_room#sun_aykkdobyhjevkiib

a=cell2mat(record_lists.cat_feature_vecs')';
str='cat_feature_vecs';
str_to_eval=['cell2mat(record_lists.' str ''')'''];
b=eval(str_to_eval);



return
map=[1,2,4,8,9];


cat_nos=record_lists.cat_nos;
cat_nos_rep=repmat(cat_nos,1,numel(map));
map_rep=repmat(map,numel(cat_nos),1);
bin=cat_nos_rep==map_rep;

bin=bin';
bin_vec=bin(:);

bin_vec=bin_vec';

no=100;
check=cell(no,1);
[check{:}]=deal(bin_vec);

% sanity_check
% 
% for i=1:size(bin,1)
%     idx=find(bin(i,:));
%     if map(idx)~=cat_nos(i)
%         keyboard;
%     end
% end