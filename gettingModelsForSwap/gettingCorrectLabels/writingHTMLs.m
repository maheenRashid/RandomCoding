% load('names_and_scores.mat');
% folder='swapObjectsInBox_midOffsets';
%folder='swapObjectsInBox_allOffsets_sizeComparison_bugFixed_gt';

folder='gt_raw_check_new_labels';
folder_fullpath=['/home/maheenr/results_temp_09_13/' folder];



dir_parent=['/results_temp_09_13/' folder];
dir_html=[dir_parent '_html'];


str_pre='after_match_';
str_im={'overlay','normal','floor'};
    
files=dir(folder_fullpath);
files=files(3:end);

fid_html=fopen(fullfile(pwd(),'sorted.html'),'w');
    
for file_no=1:numel(files)
        
        id=files(file_no).name;
        
        fid_score=fopen(fullfile(folder_fullpath,id,'scores_and_offsets.txt'));
        data=textscan(fid_score,'%s','delimiter','\n');
        data=data{1};
        fclose(fid_score);
        
        
        
        dir_in_curr=fullfile(dir_parent,id,'renderings');
        dir_in_curr_rep=strrep(dir_in_curr,'#','%23');
        
        fprintf(fid_html,'%s\n',[id '<br>']);
        
        if numel(data)>1
        fprintf(fid_html,'%s\n',[data{2} '<br>']);
        fprintf(fid_html,'%s\n',[data{3} '<br>']);
        end
%         fprintf(fid_html,'%s\n',['<img width="50%" src="' fullfile(dir_dpm,[id_cut '.jpg']) '"><br>']);
        
        
%         for j=1:size(str_pre,1)
            for i=1:numel(str_im)
                fprintf(fid_html,'%s\n',['<img width="30%" src="' [fullfile(dir_in_curr_rep,str_pre) str_im{i} '.png'] '">']);
            end
            fprintf(fid_html,'%s\n','<br>');
%         end
        
        
 end
    fprintf(fid_html,'%s\n','<html>');
    fclose(fid_html);

