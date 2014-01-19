function [out_file_name]=writeHTML(params,neighbour_flag)
if nargin<2
    neighbour_flag=0;
end

if neighbour_flag
    out_file_name=writeHTML_neighbours(params);
else
    out_file_name=writeHTML_normal(params);
end

end

function out_file_name=writeHTML_neighbours(params)
dir_model=params.dir_model;
dir_n=params.dir_n;
in_dir_pre=params.in_dir_pre;
in_dir_pre_html=params.in_dir_pre_html;
str_pre=params.str_pre;
str_post=params.str_post;
str_pre_nn=params.str_pre_nn;
str_post_nn=params.str_post_nn;
html_name=params.html_name;

in_dir=[in_dir_pre dir_model];
in_dir_html=[in_dir_pre_html dir_model];
in_dir_n=[in_dir_pre dir_n];
in_dir_n_html=[in_dir_pre_html dir_n];

out_dir=[in_dir '_html'];
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end

out_file_name=fullfile(out_dir,html_name);
fid_html=fopen(out_file_name,'w');

models=dir(in_dir);
models=models(3:end);
for model_no=1:numel(models)
    id=models(model_no).name;
    fprintf(fid_html,'%s\n',[id '<br>']);
    dir_in_curr_rep=fullfile(in_dir_html,id,'renderings');
    dir_in_curr_rep=strrep(dir_in_curr_rep,'#','%23');
    nn_path=fullfile(in_dir_n,id);
    nn_paths=getNeighbourPaths(nn_path,in_dir_n_html,id);
    printPictures(fid_html,dir_in_curr_rep,str_pre,str_post,30,0);
    printPictures(fid_html,nn_paths,str_pre_nn,str_post_nn,20,1);
end
fprintf(fid_html,'%s\n','<html>');
fclose(fid_html);
end

function out_file_name=writeHTML_normal(params)

dir_model=params.dir_model;
dir_n=params.dir_n;
in_dir_pre=params.in_dir_pre;
in_dir_pre_html=params.in_dir_pre_html;
str_pre=params.str_pre;
str_post=params.str_post;
html_name=params.html_name;


in_dir=[in_dir_pre dir_model];
in_dir_html=[in_dir_pre_html dir_model];

out_dir=[in_dir '_html'];
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end

out_file_name=fullfile(out_dir,html_name);
fid_html=fopen(out_file_name,'w');

models=dir(in_dir);
models=models(3:end);
for model_no=1:numel(models)
    id=models(model_no).name;
    fprintf(fid_html,'%s\n',[id '<br>']);
    dir_in_curr_rep=fullfile(in_dir_html,id,'renderings');
    dir_in_curr_rep=strrep(dir_in_curr_rep,'#','%23');
    printPictures(fid_html,dir_in_curr_rep,str_pre,str_post,30,0);
end
fprintf(fid_html,'%s\n','<html>');
fclose(fid_html);


end

function nn_paths=getNeighbourPaths(nn_path,in_dir_n_html,id)
inners=dir(nn_path);
inners={inners(3:end).name};
nn_paths=cell(numel(inners),1);
for j=1:numel(inners)
    in_in=dir(fullfile(nn_path,inners{j}));
    in_in={in_in(3:end).name};
    temp=fullfile(in_dir_n_html,id,inners{j},in_in{1},'renderings');
    nn_paths{j}=strrep(temp,'#','%23');
end
end

function printPictures(fid_html,dir_in_curr_rep,str_pre,str_post,size_im,row_print)
if ~iscell(dir_in_curr_rep)
    dir_in_curr_rep={dir_in_curr_rep};
end
for k=1:numel(dir_in_curr_rep)
    for j=1:numel(str_pre)
        for i=1:numel(str_post)
            fprintf(fid_html,'%s\n',['<img width="' num2str(size_im) ...
                '%" src="' [fullfile(dir_in_curr_rep{k},str_pre{j}) str_post{i} '.png'] '">']);
        end
        if ~row_print
            fprintf(fid_html,'%s\n','<br>');
        end
    end
end
if row_print
    fprintf(fid_html,'%s\n','<br>');
end
end