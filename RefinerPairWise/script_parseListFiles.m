ccc
dir_parent='/home/maheenr/results_temp_09_13';
% folder='swapAllCombos_unique_10_gt_writeAndScoreLists';
folder='swapAllCombos_unique_10_auto_writeAndScoreLists';

out_dir=fullfile(dir_parent,[folder '_html'],'record_lists');
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end

ids=dir(fullfile(dir_parent,folder));
ids=ids(3:end);
ids={ids(:).name};

matlabpool open;
parfor model_no=1:numel(ids)
    id_curr=ids{model_no};
    check=dir(fullfile(dir_parent,folder,id_curr,'renderings','list*.png'));
    check={check(:).name};
    if isempty(check)
        continue;
    end
    
    out_file_name=fullfile(out_dir,[id_curr '.mat']);
    
    if exist(out_file_name,'file')
        continue;
    else
        dummy=0;
        parsave(out_file_name,dummy);
    end
    
    fname=fullfile(dir_parent,folder,id_curr,'lists_and_scores.txt');
    fid=fopen(fname);
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
    
    record_lists=struct();
    
    record_lists.idx_on_ground=temp_all{1};
    record_lists.box_nos=temp_all{2};
    record_lists.cat_nos=temp_all{3};
    record_lists.box_dim=temp_all{4};
    
    scores=data(score_idx);
    lists=data(score_idx+1);
    
    record_lists.scores=cellfun(@(x,y) str2num(x(y(1):end)),scores,...
        cellfun(@(x) regexpi(x,'[0-9]'),scores,'UniformOutput',0),'UniformOutput',0);
    record_lists.lists=cellfun(@(x,y) str2num(x(y(1):end)),lists,...
        cellfun(@(x) regexpi(x,'[0-9]'),lists,'UniformOutput',0),'UniformOutput',0);
    
    parsave(out_file_name,record_lists);
    
end
matlabpool close




