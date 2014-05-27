function [cellCommands]=getCellCommands_cubeMethod(cellCommands,model_names,params,changeMatchName)

if nargin<4
    changeMatchName=1;
end

cellCommands_org=cellCommands;
out_dir_pre=params.out_dir;
c_file=params.c_file;
text_dirs=params.text_dirs;
justNameFlag=params.justNameFlag;



model_name_col=cellfun(@(x) regexpi(x,' ','split'),cellCommands_org,...
    'UniformOutput',0);
model_name_col=cellfun(@(x) x{2},model_name_col,'UniformOutput',0);


cellCommand_new=cell(numel(model_names),1);
for model_no=1:numel(model_names)
    
    model_name=model_names{model_no};
    
    bin=~cellfun(@isempty,strfind(model_name_col,model_name));
    
    text_file_name_pre=strrep(model_name_col{bin},'/','#');
    
    
    orig_dist=0;
    
    cellCommand_rel=cellCommands_org(bin);
    cellCommand_rel=cellCommand_rel{1};
    
    cellCommand_rel_split=regexpi(cellCommand_rel,' ','split');
    
    cellCommand_rel=strrep(cellCommand_rel,cellCommand_rel_split{1},c_file);
    cellCommand_rel=strrep(cellCommand_rel,cellCommand_rel_split{3},...
        [out_dir_pre,text_file_name_pre,'/']);
    
    if changeMatchName
    cellCommand_rel=strrep(cellCommand_rel,cellCommand_rel_split{5},...
        [model_name '.txt']);
    end
    
    start_idx=strfind(cellCommand_rel,cellCommand_rel_split{7});
    start_idx=numel(cellCommand_rel_split{7})+start_idx;
    cellCommand_rel(start_idx:end)=[];
    cellCommand_rel=[cellCommand_rel ' ' num2str(orig_dist)];
    
    for text_no=1:numel(text_dirs)
        if justNameFlag(text_no)==0
            text_file_name=[text_file_name_pre '.txt'];
        else
            text_file_name=[model_name '.txt'];
        end
        text_fullpath=[text_dirs{text_no} text_file_name];
        cellCommand_rel=[cellCommand_rel ' ' text_fullpath];
    end
    
    cellCommand_new{model_no}=cellCommand_rel;
    
end
cellCommands=cellCommand_new;


end