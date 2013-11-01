ccc
dir_parent='/home/maheenr/results_temp_09_13';
folder='swapAllCombos_unique_10_auto';

out_dir=fullfile(dir_parent,[folder '_html']);
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end




ids=dir(fullfile(dir_parent,folder));
ids=ids(3:end);
ids={ids(:).name};
num_of_im=numel(ids);
temp=cell(1,num_of_im);
record_lists=struct('id',ids,'idx_on_ground',temp,'box_nos',temp,'cat_nos',temp,...
    'box_dim',temp,'scores',temp,'lists',temp);

matlabpool open;
parfor model_no=1:numel(record_lists)
fname=fullfile(dir_parent,folder,record_lists(model_no).id,'lists_and_scores.txt');
fid=fopen(fname);
if fid<0
    continue
end
data=textscan(fid,'%s','delimiter','\n');
fclose(fid);

data=data{1};

bin_str=find(~cellfun(@isempty,cellfun(@(x) regexpi(x,'[a-zA-Z]'),data,'UniformOutput',0)));
score_idx=find(~cellfun(@isempty,cellfun(@(x) strfind(x,'score'),data,'UniformOutput',0)));
bin_str=[bin_str(1:4);score_idx(1)];
strs=data(bin_str(1:4));
temp_all=cell(1,numel(strs));
for i=1:numel(strs)
    temp=data(bin_str(i)+1:bin_str(i+1)-1);
    temp=cellfun(@(x) str2num(x),temp,'UniformOutput',0);
    temp=cell2mat(temp);
    temp_all{i}=temp;
    
end
record_lists(model_no).idx_on_ground=temp_all{1};
record_lists(model_no).box_nos=temp_all{2};
record_lists(model_no).cat_nos=temp_all{3};
record_lists(model_no).box_dim=temp_all{4};

scores=data(score_idx);
lists=data(score_idx+1);

record_lists(model_no).scores=cellfun(@(x,y) str2num(x(y(1):end)),scores,cellfun(@(x) regexpi(x,'[0-9]'),scores,'UniformOutput',0),'UniformOutput',0);
record_lists(model_no).lists=cellfun(@(x,y) str2num(x(y(1):end)),lists,cellfun(@(x) regexpi(x,'[0-9]'),lists,'UniformOutput',0),'UniformOutput',0);

end
matlabpool close

save(fullfile(out_dir,'record_lists.mat'),'record_lists');


