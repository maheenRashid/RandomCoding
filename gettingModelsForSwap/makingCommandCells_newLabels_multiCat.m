ccc

command_cells=dir(fullfile('command_cells','*.mat'));
names=cell(1,numel(command_cells));
for i=1:numel(command_cells)
    names{i}=command_cells(i).name(1:end-4);
end

names=names(2);
% return

out_parent='swapModel_moreBoxes_cellCommands';
if ~exist(out_parent,'dir')
    mkdir(out_parent);
end

in_dir_name='swapModel_moreBoxes';
file_c_name='swapModelInBox_sort_diffIdx'

for name_no=1:numel(names)
    load(fullfile('command_cells',[names{name_no} '.mat']),'cellCommands');
    load(fullfile([in_dir_name '_' names{name_no} '_html.mat']),'cell_for_command');
    
    out_name=regexpi(names{name_no},'_','split');
    out_name=sprintf('_%s',out_name{end-1:end});
    out_name=[in_dir_name out_name];
    
    commands_final=cell(0,1);
    for command_no=1:numel(cellCommands)
        command_curr=cellCommands{command_no};
        command_curr=regexpi(command_curr,' ','split');
        id=strrep(command_curr{2},'/','#');
        idx=find(strcmp(id,cell_for_command(1,:)));
        if numel(idx)~=1
            continue
%             keyboard;
        end
        
        gettingCommandsToAdd_newLabels_multiCat
        
        commands_final=[commands_final;commands_to_add_single];
    end
    cellCommands=commands_final;
    save(fullfile(out_parent,[out_name '.mat']),'cellCommands');
%     keyboard;
end

