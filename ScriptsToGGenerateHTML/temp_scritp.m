ccc

fid=fopen('scores_temp.txt');

scores_curr=zeros(2,6);
im_str_curr=cell(4,1);
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
    gt_line_max=data{2*max_idx+3};
    temp=regexpi(gt_line_max,' ','split');
    im_pre_max=['each_rep_' temp{4} '_' temp{6} '_' temp{8}(1:end-1) '_'];
    
    str_im={'overlay','normal','floor'};
    
temp=data([2,3,end-1:end]);
out_temp=[folder '_html'];
mkdir(out_temp);

for i=1:2:numel(temp)
    temp_split=regexpi(temp{i},' ','split');
    scores_curr((i+1)/2,1)=str2num(temp_split{end});
    temp_split=regexpi(temp{i+1},' ','split');
    scores_curr((i+1)/2,2:end)=cellfun(@str2num,temp_split(10:2:end));
    pre_str=['each_rep_' temp_split{4} '_' temp_split{6} '_' temp_split{8}(1:end-1) '_'];
    im_str_curr{i}=pre_str;
end
im_str_curr{2}='orig_with_cube_';
im_str_curr{4}='final_with_cube_';
