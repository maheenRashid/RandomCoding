cell_for_command_curr=cell_for_command(:,idx);

commands_to_add_single_meta=cell(0,1);

for box_no=1:size(cell_for_command_curr{3},2)
    
    
    matches_curr=cell_for_command_curr{3}{1,box_no};
    box_curr_no=cell_for_command_curr{3}{2,box_no};
    commands_to_add=cell(numel(matches_curr),numel(command_curr)+1);
    
    for i=1:size(commands_to_add,2)-1
        if i==1
            str=command_curr{i};
            str=strrep(str,'swapObjectsInBox_renderBestBoxAll',file_c_name);
            [commands_to_add{:,i}]=deal(str);
            continue
        end
        
        if i==3
            str=command_curr{i};
            str=strrep(str,'swapObjectsInBox_allOffsets_sizeComparison',in_dir_name);
            for j=1:size(commands_to_add,1)
                commands_to_add{j,i}=[str num2str(box_curr_no) '/' matches_curr{j} '/'];
                commands_to_add{j,end}=[matches_curr{j} '.txt'];
            end
            continue
        end
        if i==size(commands_to_add,2)-1
            str=command_curr{i};
            str=regexpi(str,'/','split');
            str_to_rep_with=command_curr{3};
            str_to_rep_with=regexpi(str_to_rep_with,'/','split');
            str_to_rep_with=str_to_rep_with{5};
            str_copy=str;
            str_copy{4}=str_to_rep_with;
            str_recon=sprintf('%s/',str_copy{:});
            str_recon=str_recon(1:end-1);
            [commands_to_add{:,i}]=deal(str_recon);
            continue
        end
        if i==size(commands_to_add,2)
            disp(test)
            [commands_to_add{:,i}]=deal([id '.txt']);
        end
        [commands_to_add{:,i}]=deal(command_curr{i});
    end
    
    commands_to_add=[commands_to_add,cell(size(commands_to_add,1),2)];
    [commands_to_add{:,end-1}]=deal(num2str(0));
    [commands_to_add{:,end}]=deal(num2str(box_curr_no));
    
    
%     keyboard;
    
    commands_to_add_single=cell(size(commands_to_add,1),1);
    for i=1:size(commands_to_add,1)
        str=sprintf('%s ',commands_to_add{i,:});
        str=str(1:end-1);
        commands_to_add_single{i}=str;
    end
    
    commands_to_add_single_meta=[commands_to_add_single_meta;commands_to_add_single];
    
end

commands_to_add_single=commands_to_add_single_meta;

% keyboard;