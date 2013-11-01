ccc

dir_parent='/home/maheenr/results_temp_09_13';
folders={'swapAllCombos_unique_10_auto_writeFloorOverlap',...
    'swapAllCombos_unique_10_gt_writeFloorOverlap'};


for folder_no=1:numel(folders)
    folder=folders{folder_no};
    out_dir=fullfile(dir_parent,[folder '_html']);
    
%     if ~exist(out_dir,'dir')
%         mkdir(out_dir);
%     end
    
%     im_names=dir(fullfile(dir_parent,folder));
%     im_names=im_names(3:end);
%     im_names={im_names(:).name};
%     temp=cell(1,numel(im_names));
%     errorLog=struct('name',temp);
     
%     matlabpool open
%     parfor i=1:numel(im_names)
%         if ~exist(fullfile(dir_parent,folder,im_names{i},'lists_and_scores.txt'),'file')
%             errorLog(i).name=im_names{i};
%         end
%     end
%     matlabpool close
%     
%     idx=cellfun(@isempty,{errorLog(:).name});
%     errorLog(idx)=[];
    
%     save(fullfile(out_dir,'errorLog.mat'),'errorLog');
    load(fullfile(out_dir,'errorLog.mat'),'errorLog');
    
    im_names={errorLog(:).name};
    matlabpool open
    parfor i=1:numel(im_names)
        rmdir(fullfile(dir_parent,folder,im_names{i}),'s');
    end
    matlabpool close

    
end