ccc

fid=fopen('scores_temp.txt');

bef_score=zeros(1,6);
aft_score=zeros(1,6);
aft_str='';
bef_str='';

data=textscan(fid,'%s','delimiter','\n');
    fclose(fid);
    data=data{1};
 temp=data(4:2:end-3);
    pred_scores=zeros(numel(temp),1);
    for i=1:numel(temp)
        temp_split=regexpi(temp{i},' ','split');
        pred_scores(i)=str2num(temp_split{end});
    end
    [max_val,max_idx]=max(pred_scores)
    gt_line_max=data{2*max_idx+1};
    temp=regexpi(gt_line_max,' ','split');
    im_pre_max=['each_rep_' temp{4} '_' temp{6} '_' temp{8}(1:end-1) '_'];
    
    str_im={'overlay','normal','floor'};