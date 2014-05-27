function [success,list_size,bad_list]=writingListFilesAfterReadingOverlap(im_name,in_dir,out_dir,thresh,timeout,blacklist)
    success=1;
    bad_list=zeros(1,0);
    if nargin<4
        thresh=0.01;
    end
    if nargin<5
        timeout=15*60;
    end
    if nargin<6
        blacklist=0;
    end
    
    fname=fullfile(in_dir,im_name,'lists_and_scores.txt');
    fid=fopen(fname);
    if fid<0
        success=0;
        return
    end
    data=textscan(fid,'%s','delimiter','\n');
    data=data{1};
    fclose(fid);
    
    
    idx=find(strcmp('floor_overlap',data));
    overlap=data(idx+1:end);
    overlap=cell2mat(cellfun(@(x) str2num(x),overlap,'UniformOutput',0));
    
    if blacklist>0
        [overlap,bad_list]=getNoNegOverlap(fname,overlap);
    end
    
    overlap_bin=overlap<thresh;
    
    %clear some memory
    overlap=[];
    data=[];
    
    overlap_bin=sparse(overlap_bin);
    
    [lists,suc]=getAllLists(triu(overlap_bin),timeout);
    if suc>0
        success=0;
        return;
    end
       
    check=cellfun(@(x) sum(ismember(x,bad_list)),lists);
    check=check>0;
    lists(check)=[];
    
    list_size=numel(lists);
    
    lists=cellfun(@(x) x-1,lists,'UniformOutput',0);
    
    filename=fullfile(out_dir,[im_name '.txt']);
    fid_w=fopen(filename,'w');
    fprintf(fid_w,'%d\n',numel(lists));
    fprintf(fid_w,'%s\n','C');
    for i=1:numel(lists)
        fprintf(fid_w,'%d\n',numel(lists{i}));
        for j=1:numel(lists{i})
            fprintf(fid_w,'%d\n',lists{i}(j));
        end
        fprintf(fid_w,'%s\n','C');
    end
    fclose(fid_w);
end

function [overlap,black_list]=getNoNegOverlap(fname,overlap)
    [record_lists]=getOtherInfoFromFile(fname);
    [bin_neg]=getBinNeg(record_lists.box_nos,record_lists.box_dim);
    black_list=find(bin_neg);
    overlap(black_list,:)=1;
    overlap(:,black_list)=1;
end