ccc
meta_dirs=dir(fullfile('../swapModelInBox_*_html'));
for meta_dir_no=1:numel(meta_dirs)
    fullfile('..',meta_dirs(meta_dir_no).name,'relevant_files.mat')
    load(fullfile('..',meta_dirs(meta_dir_no).name,'relevant_files.mat'))
    dirs=relevant_files(end,:);
    split_dirs_cell=cellfun(@(x) regexpi(x,'/','split'),dirs,'UniformOutput',0);
    
    split_dirs=struct('field',split_dirs_cell);
    
    matlabpool open
    parfor i=1:numel(split_dirs)
        split_dir_curr=split_dirs(i).field;
        split_dir_curr=split_dir_curr(2:end);
        dir_parent=sprintf('/%s',split_dir_curr{1:end-2});
        dirs_in_parent=dir(dir_parent);
        dirs_in_parent=dirs_in_parent(3:end);
        dir_to_keep=split_dir_curr{end-1};
        cell_paths=cell(1,0);
        for dir_no=1:numel(dirs_in_parent)
            bin=strcmp(dirs_in_parent(dir_no).name,dir_to_keep);
            if bin
                continue;
            else
                cell_paths=[cell_paths fullfile(dir_parent,dirs_in_parent(dir_no).name)];
            end
        end
    	if numel(dirs_in_parent)-numel(cell_paths)==1
    		cellfun(@(x) rmdir(x,'s'),cell_paths);
    	end
    end
    matlabpool close

end