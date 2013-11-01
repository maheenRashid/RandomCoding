close all; clear all; clc

folder='swapBedBox_minOffset_allOrient_rerun';
dir_parent=['/home/maheenr/results/' folder];

dir_files=dir(dir_parent);
dir_files=dir_files(3:end);

dir_dpm='/home/maheenr/results/bed_dpm';
out_temp=[folder '_html'];
mkdir(out_temp);

% id='b#bedroom#sun_aacbujjopwrmwujb'

fid_html=fopen(fullfile(out_temp,[folder '.html']),'w');
im_count=1;
fprintf(fid_html,'%s\n','<html>');
scores_and_im_names=cell(7,numel(dir_files));

for file_no=1:numel(dir_files)
    id=dir_files(file_no).name;
    fid=fopen(fullfile(dir_parent,id,'scores_and_offsets.txt'));
    
    %     id_rep=strrep(id,'#','%23');
    dir_curr=fullfile(dir_parent,id,'renderings');
    id_cut=regexpi(id,'#','split');
    id_cut=id_cut{end};
    %     fid=fopen('scores_and_offsets.txt');
    
    scores_curr=zeros(3,6);
    im_str_curr=cell(5,1);
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
    
    temp=data([2,3,end-1:end,2*max_idx+2,2*max_idx+3]);
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
    scores_and_im_names{1,file_no}=id;
    scores_and_im_names{2,file_no}=scores_curr;
    scores_and_im_names(3:end,file_no)=im_str_curr(:);
    
    str_im={'overlay','normal','floor'};
    
    fprintf(fid_html,'%s\n',[data{1} '<br>']);
    
    copyfile(fullfile(dir_dpm,[id_cut '.jpg']),fullfile(out_temp,[num2str(im_count) '.jpg']));
    fprintf(fid_html,'%s\n',['<img width="50%" src="' [num2str(im_count) '.jpg'] '"><br>']);
    im_count=im_count+1;
    
    fprintf(fid_html,'%s\n',[data{end} '<br>']);
    
    
    for i=1:numel(str_im)
        copyfile([fullfile(dir_curr,'final_with_cube_') str_im{i} '.png'],fullfile(out_temp,[num2str(im_count) '.png']));
        fprintf(fid_html,'%s\n',['<img width="25%" src="' [num2str(im_count) '.png'] '">']);
        im_count=im_count+1;
    end
    fprintf(fid_html,'%s\n','<br>');
    
    fprintf(fid_html,'%s\n',[data{2*max_idx+3} '<br>']);
    for i=1:numel(str_im)
        copyfile([fullfile(dir_curr,im_pre_max) str_im{i} '.png'],fullfile(out_temp,[num2str(im_count) '.png']));
        fprintf(fid_html,'%s\n',['<img width="25%" src="' [num2str(im_count) '.png'] '">']);
        im_count=im_count+1;
    end
    fprintf(fid_html,'%s\n','<br>');
    
end
fprintf(fid_html,'%s\n','<html>');
fclose(fid_html);

save(fullfile(out_temp,'scores_and_im_names_withForce.mat'),'scores_and_im_names');
