load('names_and_scores.mat');
% folder='swapObjectsInBox_midOffsets';
folder='swapObjectsInBox_allOffsets_sizeComparison_bugFixed';

dir_parent=['/results_temp_09_13/' folder];
dir_dpm='/writeDPMFiles/im_dpm_greater_-1';
dir_html=[dir_parent '_html'];


addpath('../');
idx_emp=cellfun(@isempty,names_and_scores(1,:));
names_and_scores(:,idx_emp)=[];
s_cell=names_and_scores(2,:);
str_graphs={'Predicted_Scores','GT_SCORE_all_px',...
    'GT_SCORE_obj_px','GT_SCORE_obj_px_strict','GT_SCORE_match_px','Floorplan_Overlap'};

str_pre=names_and_scores(end-1:end,:);
str_im={'overlay','normal','floor'};
    

[h_all,idx_sorted,val_sorted]=getGraphsDiff(s_cell,str_graphs);


for fig_h_no=1:numel(h_all)
    mkdir(str_graphs{fig_h_no});
    saveas(h_all(fig_h_no),fullfile(str_graphs{fig_h_no},[str_graphs{fig_h_no} '_deltagraph.png']));
    close(h_all(fig_h_no));
end


for score_no=1:numel(idx_sorted)
    idx_curr=idx_sorted{score_no};
    idx_curr=flipud(idx_curr);
    
    val_curr=val_sorted{score_no};
    val_curr=flipud(val_curr);
    
    dir_out_curr=fullfile(str_graphs{score_no});
    fid_html=fopen(fullfile(dir_out_curr,['sorted.html']),'w');
    
    dir_graph=fullfile(dir_html,dir_out_curr);
    
    fprintf(fid_html,'%s\n','<html>');
    fprintf(fid_html,'%s\n',['<img width="50%" src="' fullfile(dir_graph,[str_graphs{score_no} '_deltagraph.png']) '"><br>']);
    
    for file_no=1:numel(idx_curr)
        
        id=names_and_scores{1,idx_curr(file_no)};
        dir_in_curr=fullfile(dir_parent,id,'renderings');
        dir_in_curr_rep=strrep(dir_in_curr,'#','%23');
        id_cut=regexpi(id,'#','split');
        id_cut=id_cut{end};
        
        fprintf(fid_html,'%s\n',[id '<br>']);
        fprintf(fid_html,'%s\n',[num2str(val_curr(file_no)) '<br>']);
        
        fprintf(fid_html,'%s\n',['<img width="50%" src="' fullfile(dir_dpm,[id_cut '.jpg']) '"><br>']);
        
        
        for j=1:size(str_pre,1)
            for i=1:numel(str_im)
                fprintf(fid_html,'%s\n',['<img width="30%" src="' [fullfile(dir_in_curr_rep,str_pre{j,idx_curr(file_no)}) str_im{i} '.png'] '">']);
            end
            fprintf(fid_html,'%s\n','<br>');
        end
        
        
    end
    fprintf(fid_html,'%s\n','<html>');
    fclose(fid_html);
end

rmpath('../');