ccc

% folder='swapObjectsInBox_allOffsets_sizeComparison_bestSortedByDPMScore_auto';

folder='models_swap';

models=dir(folder);
% isub = [models(:).isdir];
% models=models(isub);
models={models(3:end).name};


fid_html=fopen('display_all_modelswap.html','w');
fprintf(fid_html,'%s\n','<html>');
for model_no=1:numel(models)
    id=models{model_no};
    fprintf(fid_html,'%s\n',[id '<br>']);
    im_list=dir(fullfile(folder,id,'*.png'));
    im_list={im_list(:).name};
%     temp=dir(fullfile(folder,id,'*.jpg'));
%     temp=temp.name;
%     im_list=[im_list temp];
    
    strs_to_prune={'floor','Floor','with_cube','withCube','final_model_','raw'};

    for prune_no=1:numel(strs_to_prune)
        bin=~cellfun(@isempty,strfind(im_list,strs_to_prune{prune_no}));
        im_list(bin)=[];
    end

    
    model_rep=strrep(id,'#','%23');
    for im_no=1:numel(im_list)
        im=imread(fullfile(folder,id,im_list{im_no}));
        im_width=size(im,2);
        im_height=size(im,1);
    
        fprintf(fid_html,'%s\n',['<img width="' num2str(im_width) '" src="' fullfile(folder,model_rep,im_list{im_no}) '">']);
        fprintf(fid_html,'%s\n','<br>');
    end

end

fprintf(fid_html,'%s\n','</html>');
fclose(fid_html);