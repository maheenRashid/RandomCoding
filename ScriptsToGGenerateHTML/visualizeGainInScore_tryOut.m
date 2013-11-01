% ccc
folder='swapBedBox_minOffset_allOrient_rerun';


% dir_parent=['/home/maheenr/results/' folder];
dir_parent=['/results/' folder];
% dir_parent=['/' folder];
% dir_dpm='/home/maheenr/results/bed_dpm';
dir_dpm='/results/bed_dpm';
% dir_dpm='/bed_dpm';
dir_html=[dir_parent '_html'];
cd (['/home/maheenr' dir_html]);
str_graphs={'Predicted_Scores','GT_SCORE_all_px',...
    'GT_SCORE_obj_px','GT_SCORE_obj_px_strict','GT_SCORE_match_px','Floorplan_Overlap'};
% addpath([folder '_html']);
load('scores_and_im_names_withForce.mat');
str_force={'','no_force','with_force'};
for force_no=2:3
    s_cell=cellfun(@(x) x([1,force_no],:),scores_and_im_names(2,:),'UniformOutput',0);
    if force_no==2
        str_pre=scores_and_im_names([4,6],:);
    else
        str_pre=scores_and_im_names([4,7],:);
    end
    [h_all,idx_sorted,val_sorted]=getGraphsDiff(s_cell,str_graphs);
%     dir_out_curr=[str_graphs{score_no} str_force{force_no}];
        mkdir(str_force{force_no});
        
        for fig_h_no=1:numel(h_all)
            saveas(h_all(fig_h_no),fullfile(str_force{force_no},[str_graphs{fig_h_no} '_deltagraph.png']));
            close(h_all(fig_h_no));
        end
        
        str_im={'overlay','normal','floor'};
    for score_no=1:numel(idx_sorted)
        idx_curr=idx_sorted{score_no};
        idx_curr=flipud(idx_curr);
        
        val_curr=val_sorted{score_no};
        val_curr=flipud(val_curr);
        
        dir_out_curr=fullfile(str_force{force_no},str_graphs{score_no});
        mkdir(dir_out_curr);
        fid_html=fopen(fullfile(dir_out_curr,['sorted.html']),'w');
        im_count=1;
        fprintf(fid_html,'%s\n','<html>');
        for file_no=1:numel(idx_curr)
            
            id=scores_and_im_names{1,idx_curr(file_no)};
            dir_in_curr=fullfile(dir_parent,id,'renderings');
            dir_in_curr_rep=strrep(dir_in_curr,'#','%23');
            id_cut=regexpi(id,'#','split');
            id_cut=id_cut{end};
            
            fprintf(fid_html,'%s\n',[id '<br>']);
            fprintf(fid_html,'%s\n',[num2str(val_curr(file_no)) '<br>']);
            
%             copyfile(fullfile(dir_dpm,[id_cut '.jpg']),fullfile(dir_out_curr,[num2str(im_count) '.jpg']));
%             fprintf(fid_html,'%s\n',['<img width="50%" src="' [num2str(im_count) '.jpg'] '"><br>']);
            fprintf(fid_html,'%s\n',['<img width="50%" src="' fullfile(dir_dpm,[id_cut '.jpg']) '"><br>']);
            im_count=im_count+1;
            
            
            for j=1:size(str_pre,1)
                for i=1:numel(str_im)
%                     copyfile([fullfile(dir_in_curr,str_pre{j,idx_curr(file_no)}) str_im{i} '.png'],fullfile(dir_out_curr,[num2str(im_count) '.png']));
                    fprintf(fid_html,'%s\n',['<img width="30%" src="' [fullfile(dir_in_curr_rep,str_pre{j,idx_curr(file_no)}) str_im{i} '.png'] '">']);
                    im_count=im_count+1;
                end
                fprintf(fid_html,'%s\n','<br>');
            end
            
            
        end
        fprintf(fid_html,'%s\n','<html>');
            fclose(fid_html);
    end
    
    
        
end
