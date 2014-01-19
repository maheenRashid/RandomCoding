ccc

k_vec=0.01:0.01:0.1;
for k_no=k_vec
    
    dir_model=['swapAllCombos_unique_3_gt_nn_' num2str(k_no)];
    dir_n=['swapAllCombos_unique_3_gt_nn_neighbours_' num2str(k_no)];
    
    in_dir=['/lustre/maheenr/results_temp_09_13/' dir_model];
    in_dir_html=['/results_temp_09_13/' dir_model];
    
    out_dir=[in_dir '_html'];
    if ~exist(out_dir,'dir')
        mkdir(out_dir);
    end
    
    models=dir(in_dir);
    models=models(3:end);
    
    str_pre={'list_best_gt','list_best_pred'};
    str_post={'_overlay','_normal','_floor'};
    
    fid_html=fopen(fullfile(out_dir,'results.html'),'w');
    for model_no=1:numel(models)
        id=models(model_no).name;
        fprintf(fid_html,'%s\n',[id '<br>']);
        dir_in_curr_rep=fullfile(in_dir_html,id,'renderings');
        dir_in_curr_rep=strrep(dir_in_curr_rep,'#','%23');
        
        for j=1:numel(str_pre)
            
            for i=1:numel(str_post)
                fprintf(fid_html,'%s\n',['<img width="30%" src="' [fullfile(dir_in_curr_rep,str_pre{j}) str_post{i} '.png'] '">']);
            end
            fprintf(fid_html,'%s\n','<br>');
        end
        
    end
    fprintf(fid_html,'%s\n','<html>');
    fclose(fid_html);
    
end