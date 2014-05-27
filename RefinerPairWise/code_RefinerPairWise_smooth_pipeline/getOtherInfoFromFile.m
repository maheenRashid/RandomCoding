function [record_lists]=getOtherInfoFromFile(fname)

    fid=fopen(fname);
    data=textscan(fid,'%s','delimiter','\n');
    fclose(fid);
    
    data=data{1};
    
    bin_str=find(~cellfun(@isempty,cellfun(@(x) regexpi(x,'[a-zA-Z]'),data,'UniformOutput',0)));
    
    bin_str_end=find(~cellfun(@isempty,strfind(data,'floor_overlap')));
    
    
    bin_str=[bin_str(1:4);bin_str_end];
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

end