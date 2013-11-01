% load('names_and_scores.mat');
% folder='swapObjectsInBox_midOffsets';
%folder='swapObjectsInBox_allOffsets_sizeComparison_bugFixed_gt';

folder_fullpath=['/home/maheenr/results_temp_09_13/' folder];


load('record_overlaps.mat');

dir_parent=['/results_temp_09_13/' folder];
dir_html=[dir_parent '_html'];


names={record_overlaps(:).id};
idx_emp=cellfun(@isempty,names);
record_overlaps(idx_emp)=[];

% str_pre=names_and_scores(end-1:end,:);
str_pre={'final_with_cube_','final_model_'}
str_im={'overlay','normal','floor'};

% files=dir(folder_fullpath);
% files=files(3:end);

fid_html=fopen(fullfile(pwd(),'sorted.html'),'w');

for file_no=1:numel(record_overlaps)
    
    id=record_overlaps(file_no).id;
    data_boxes=record_overlaps(file_no).match_data;
    
    fprintf(fid_html,'%s\n',[id '<br>']);
    
    for match_no=1:numel(data_boxes)
        box_no=data_boxes(match_no).box_no;
        id_match=data_boxes(match_no).match_id;
        
        dir_in_curr=fullfile(dir_parent,id,box_no,id_match,'renderings');
        dir_in_curr_rep=strrep(dir_in_curr,'#','%23');
        
        for j=1:numel(str_pre)
            if match_no>1 && j==1
                continue
            end
            
            for i=1:numel(str_im)
                fprintf(fid_html,'%s\n',['<img width="30%" src="' [fullfile(dir_in_curr_rep,str_pre{j}) str_im{i} '.png'] '">']);
            end
            fprintf(fid_html,'%s\n','<br>');
        end
    end
    
end
fprintf(fid_html,'%s\n','<html>');
fclose(fid_html);

