function [pred_score,list,gt_score]=getListInfoFromFile(fname)

    fid=fopen(fname);
    data=textscan(fid,'%s','delimiter','\n');
    fclose(fid);
    data=data{1};
    
    idx=~cellfun(@isempty,strfind(data,'After list'));
    idx=find(idx);
    if mod(numel(idx),2)~=0
        fprintf('WHAT!\n');
        list=[];
        gt_score=[];
        pred_score=[];
        return;
    end
    
    pred_idx=idx(1:2:end);
    gt_idx=idx(2:2:end);
    pred_data=data(pred_idx);
    gt_data=data(gt_idx);
    
    pred_data=cellfun(@(x) regexpi(x,' ','split'),pred_data,'UniformOutput',0);
    pred_score=cellfun(@(x) str2num(x{end}),pred_data);
    list=cellfun(@(x) x{3},pred_data,'UniformOutput',0);
    
    gt_score=cellfun(@(x) regexpi(x,' ','split'),gt_data,'UniformOutput',0);
    gt_score=cellfun(@(x) x(5:2:end),gt_score,'UniformOutput',0);
    gt_score=cellfun(@(x) cellfun(@str2num,x),gt_score,'UniformOutput',0);
    gt_score=cell2mat(gt_score);
    
    list=cellfun(@(x) regexpi(x,'[_:]','split'),list,'UniformOutput',0);
    list=cellfun(@(x) x(1:end-1),list,'UniformOutput',0);
    list=cellfun(@(x) cellfun(@str2num,x),list,'UniformOutput',0);
    


end