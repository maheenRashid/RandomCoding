ccc

dirs_html=dir(fullfile(pwd(),'swapModelInBox_newLabels*'));
dirs_html={dirs_html(:).name};
dirs=cellfun(@(x) x(1:end-5),dirs_html,'UniformOutput',0);

dir_cmd='../swapModelInBox_newLabels_cellCommands';

out_dir_meta='swapModelInBox_sort_refine';
if ~exist(out_dir_meta,'dir')
    mkdir(out_dir_meta)
end


bin_pred=~cellfun(@isempty,strfind(dirs,'Pred'))
file_to_run='/home/maheenr/Image-Modeling/OSMesa-Renderer/swapModelInBox_sort_refine';


for dir_no=2:numel(dirs_html)

    load(fullfile(dirs_html{dir_no},'relevant_files.mat'));
    load(fullfile(dir_cmd,[dirs{dir_no} '.mat']));
    
    
    cellCommands_refine=cell(size(relevant_files,2),1);
    for file_no=1:size(relevant_files,2)
        file_no
        path=relevant_files{end,file_no};
        
        path=strrep(path,'/lustre','/home');
        path=strrep(path,'renderings','');
        
        idx=find(~cellfun(@isempty,strfind(cellCommands,path)));
        
        cellCommand_curr=cellCommands{idx};
        
        cellCommand_curr_split=regexpi(cellCommand_curr,' ','split');
        
        out_dir=cellCommand_curr_split{3};
        out_dir=regexpi(out_dir,'/','split');
        out_dir{5}=[out_dir{5} '_refine'];
        
        out_dir=out_dir(1:end-1);
        out_dir=sprintf('%s/',out_dir{:});
        
        cellCommand_curr_split{3}=out_dir;
        cellCommand_curr_split{1}=file_to_run;
        cellCommand_curr_split=[cellCommand_curr_split num2str(bin_pred(dir_no))];
        cellCommand_curr_join=sprintf('%s ',cellCommand_curr_split{:});
        cellCommand_curr_join=cellCommand_curr_join(1:end-1);
        
        cellCommands_refine{file_no}=cellCommand_curr_join;
    
    end
    
    cellCommands=cellCommands_refine;
    save(fullfile(out_dir_meta,[dirs{dir_no} '_refine.mat']),'cellCommands');




end