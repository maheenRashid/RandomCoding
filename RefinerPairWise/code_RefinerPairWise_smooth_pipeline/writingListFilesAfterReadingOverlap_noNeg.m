function [success]=writingListFilesAfterReadingOverlap_noNeg(im_name,in_dir,out_dir,thresh,timeout)
    success=1;
    if nargin<4
        thresh=0.01;
    end
    if nargin<5
        timeout=15*60;
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
    
    [record_lists]=getOtherInfoFromFile(fname)
    
    idx=find(strcmp('floor_overlap',data));
    overlap=data(idx+1:end);
    overlap=cell2mat(cellfun(@(x) str2num(x),overlap,'UniformOutput',0));
    
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

function box_dim=getBoxDim(data)
     
    idx=find(strcmp('floor_overlap',data));
    overlap=data(idx+1:end);
    overlap=cell2mat(cellfun(@(x) str2num(x),overlap,'UniformOutput',0));
    
end