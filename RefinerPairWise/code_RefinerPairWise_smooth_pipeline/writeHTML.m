function [out_file_name]=writeHTML(params,neighbour_flag)
if nargin<2
    neighbour_flag=0;
end

if neighbour_flag==1
    out_file_name=writeHTML_neighbours(params);
elseif neighbour_flag==0
    out_file_name=writeHTML_normal(params);
else
    out_file_name=writeHTML_multipleFolders(params);
end

end

function out_file_name=writeHTML_neighbours(params)
dir_model=params.dir_model;
% dir_n=params.dir_n;
in_dir_pre=params.in_dir_pre;
in_dir_pre_html=params.in_dir_pre_html;
str_pre=params.str_pre;
str_post=params.str_post;
str_pre_nn=params.str_pre_nn;
str_post_nn=params.str_post_nn;
html_name=params.html_name;


% params.in_dir_pre_n='/lustre/maheenr/new_3dgp/indoorunderstanding_3dgp-master/results_our/'
%     params.in_dir_pre_n_html='/new_3dgp/indoorunderstanding_3dgp-master/results_our/'
    

in_dir=[in_dir_pre dir_model];
in_dir_html=[in_dir_pre_html dir_model];
in_dir_n=[params.in_dir_pre_n];
in_dir_n_html=[params.in_dir_pre_n_html];

out_dir=[in_dir '_html'];
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end

out_file_name=fullfile(out_dir,html_name);
fid_html=fopen(out_file_name,'w');



if isfield(params,'models')
    models=params.models;
else
    models=dir(in_dir);
    models=models(3:end);
    models={models(:).name};
end


for model_no=1:numel(models)
    id=models{model_no};
    id_n=regexpi(id,'#','split');
    id_n=id_n{end};
    
    
    fprintf(fid_html,'%s\n',[id '<br>']);
    dir_in_curr_rep=fullfile(in_dir_html,id,'renderings');
    dir_in_curr_rep=strrep(dir_in_curr_rep,'#','%23');
%     nn_path=fullfile(in_dir_n,id_n);
    nn_paths={fullfile(in_dir_n_html,id_n)};
    if isfield(params,'keepFullID')
        temp=fullfile(in_dir_n_html,id,'renderings');
        temp=strrep(temp,'#','%23');
        nn_paths={temp};
    end
        
%     nn_paths=getNeighbourPaths(nn_path,in_dir_n_html,id_n);
    printPictures(fid_html,dir_in_curr_rep,str_pre,str_post,20,0);
    printPictures(fid_html,nn_paths,str_pre_nn,str_post_nn,40,0);
end
fprintf(fid_html,'%s\n','<html>');
fclose(fid_html);
end

function out_file_name=writeHTML_normal(params)

dir_model=params.dir_model;

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





function out_file_name=writeHTML_multipleFolders(params)

dir_model=params.dir_model;

in_dir_pre=params.in_dir_pre;
in_dir_pre_html=params.in_dir_pre_html;
str_pre=params.str_pre;
str_post=params.str_post;
html_name=params.html_name;
out_dir=params.html_folder;
models=params.models;


% out_dir=[in_dir '_html'];
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end

out_file_name=fullfile(out_dir,html_name);
fid_html=fopen(out_file_name,'w');

for model_no=1:numel(models)
    id=models{model_no};
    
    fprintf(fid_html,'%s\n',[id '<br>']);
    for dir_no=1:size(dir_model,2)
        in_dir=[in_dir_pre dir_model{model_no,dir_no}];
        in_dir_html=[in_dir_pre_html dir_model{model_no,dir_no}];
        dir_in_curr_rep=fullfile(in_dir_html,id,'renderings');
        dir_in_curr_rep=strrep(dir_in_curr_rep,'#','%23');
        printPictures(fid_html,dir_in_curr_rep,str_pre,str_post,30,1);
    end
end
fprintf(fid_html,'%s\n','<html>');
fclose(fid_html);


end

