% 
% mat_files=cell(size(folders));
% for i=1:numel(folders)
%     folder=folders{i};
%     path_to_text=text_file_path;
    
    
 cellCommands_rep=cellfun(@(x) strrep(x,'swapObjectsInBox_check',c_file_to_run),cellCommands,'UniformOutput',0);
 cellCommands_rep=cellfun(@(x) strrep(x,file,out_name),cellCommands_rep,'UniformOutput',0);
 ids=cellfun(@(x) strrep(x{2},'/','#'),cellfun(@(x) regexpi(x,' ','split'),cellCommands,'UniformOutput',0),'UniformOutput',0);
 path_to_text=strrep(path_to_text,'\','/');
 path_to_bestList=strrep(path_to_bestList,'\','/');
 cellCommands_rep=cellfun(@(x,y) [x ' ' path_to_text '/' y '.txt'],cellCommands_rep,ids,'UniformOutput',0);
 cellCommands_rep=cellfun(@(x,y) [x ' ' path_to_bestList '/' y '.txt'],cellCommands_rep,ids,'UniformOutput',0);
 
 cellCommands=cellCommands_rep;
 
 save([out_name '.mat'],'cellCommands');
 mat_files_path=out_name;
% end

