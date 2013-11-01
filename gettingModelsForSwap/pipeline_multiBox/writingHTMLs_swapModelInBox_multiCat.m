% load('names_and_scores.mat');
% folder='swapObjectsInBox_midOffsets';
%folder='swapObjectsInBox_allOffsets_sizeComparison_bugFixed_gt';

folder_fullpath=['/home/maheenr/results_temp_09_13/' folder];


load('names_and_scores.mat');

dir_parent=['/results_temp_09_13/' folder];
dir_html=[dir_parent '_html'];

idx_emp=cellfun(@isempty,names_and_scores(1,:));
names_and_scores(:,idx_emp)=[];

str_pre=names_and_scores(end-1:end,:);
str_im={'overlay','normal','floor'};
    
files=dir(folder_fullpath);
files=files(3:end);

fid_html=fopen(fullfile(pwd(),'sorted.html'),'w');
    
for file_no=1:size(names_and_scores,2)
%     numel(files)
        
%         id=files(file_no).name;
        id=names_and_scores{1,file_no};
        id_match=names_and_scores{2,file_no};
        dir_in_curr=fullfile(dir_parent,id,id_match,'renderings');
        dir_in_curr_rep=strrep(dir_in_curr,'#','%23');

        dir_in_curr=fullfile(dir_parent,id,id_match,'renderings');
        dir_in_curr_rep=strrep(dir_in_curr,'#','%23');
        
        fprintf(fid_html,'%s\n',[id '<br>']);
        
        
        
        str_pre_curr=str_pre(:,file_no);
        for j=1:size(str_pre_curr,1)
            for i=1:numel(str_im)
                fprintf(fid_html,'%s\n',['<img width="30%" src="' [fullfile(dir_in_curr_rep,str_pre_curr{j}) str_im{i} '.png'] '">']);
            end
            fprintf(fid_html,'%s\n','<br>');
        end
        
        
 end
    fprintf(fid_html,'%s\n','<html>');
    fclose(fid_html);

