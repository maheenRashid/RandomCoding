function cellCommands_rep=createRenderListsMat(cellCommands,c_file_to_run,path_to_text,...
    path_to_bestList,out_name,file)

% params with struct:
% (struct, path_to_bestList, out_name)

if nargin==3
    params=cellCommands;
    path_to_bestList=c_file_to_run;
    out_name=path_to_text;
    
    cellCommands=params.cellCommands;
    c_file_to_run=params.c_file_to_run;
    path_to_text=params.path_to_text;
    file=params.file;
end



cellCommands_rep=cellfun(@(x) strrep(x,'swapObjectsInBox_check',c_file_to_run),cellCommands,'UniformOutput',0);

if iscell(out_name)
    out_name=reshape(out_name,size(cellCommands_rep));
    cellCommands_rep=cellfun(@(x,y) strrep(x,file,y),cellCommands_rep,out_name,'UniformOutput',0);
else
    cellCommands_rep=cellfun(@(x) strrep(x,file,out_name),cellCommands_rep,'UniformOutput',0);
end

ids=cellfun(@(x) strrep(x{2},'/','#'),cellfun(@(x) regexpi(x,' ','split'),cellCommands,'UniformOutput',0),'UniformOutput',0);

cellCommands_rep=cellfun(@(x,y) [x ' ' path_to_text '/' y '.txt'],cellCommands_rep,ids,'UniformOutput',0);
if iscell(path_to_bestList)
    path_to_bestList=reshape(path_to_bestList,size(cellCommands_rep));
    cellCommands_rep=cellfun(@(x,y) [x ' ' y],cellCommands_rep,path_to_bestList,'UniformOutput',0);
else
    cellCommands_rep=cellfun(@(x,y) [x ' ' path_to_bestList '/' y '.txt'],cellCommands_rep,ids,'UniformOutput',0);
end
cellCommands_rep=cellfun(@(x) strrep(x,'\','/'),cellCommands_rep,'UniformOutput',0);
end