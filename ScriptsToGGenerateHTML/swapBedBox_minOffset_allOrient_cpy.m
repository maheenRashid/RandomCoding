close all; clear all; clc

dir_parent='/home/maheenr/results/swapBedBox_minOffset_allOrient';

dir_files=dir(dir_parent);
dir_files=dir_files(3:end);

dir_dpm='/home/maheenr/results/bed_dpm';
out_temp='temp_swap_bed';
mkdir(out_temp);

% id='b#bedroom#sun_aacbujjopwrmwujb'

fid_html=fopen(fullfile(out_temp,'swapBedBox_minOffset_allOrient.html'),'w');
im_count=1;
fprintf(fid_html,'%s\n','<html>');
for file_no=1:numel(dir_files)
    id=dir_files(file_no).name;
    fid=fopen(fullfile(dir_parent,id,'scores_and_offsets.txt'));
%     id_rep=strrep(id,'#','%23');
    dir_curr=fullfile(dir_parent,id,'renderings');
    id_cut=regexpi(id,'#','split');
    id_cut=id_cut{end};
%     fid=fopen('scores_and_offsets.txt');
    
    data=textscan(fid,'%s','delimiter','\n');
    fclose(fid);
    data=data{1};
    
    temp=data(2:2:end-3);
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
    % data(2*max_idx)
    % data(2*max_idx+1)
    
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
    
    fprintf(fid_html,'%s\n',[data{2*max_idx+1} '<br>']);
    for i=1:numel(str_im)
        copyfile([fullfile(dir_curr,im_pre_max) str_im{i} '.png'],fullfile(out_temp,[num2str(im_count) '.png']));
        fprintf(fid_html,'%s\n',['<img width="25%" src="' [num2str(im_count) '.png'] '">']);
        im_count=im_count+1;
    end
    fprintf(fid_html,'%s\n','<br>');
    
end
fprintf(fid_html,'%s\n','<html>');
fclose(fid_html);
