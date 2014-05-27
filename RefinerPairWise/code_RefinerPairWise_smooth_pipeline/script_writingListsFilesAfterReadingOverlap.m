ccc


% dir_parent='/home/maheenr/results_temp_09_13';
% folders={'swapAllCombos_unique_10_auto_writeFloorOverlap',...
%     'swapAllCombos_unique_10_gt_writeFloorOverlap'};


dir_parent='/lustre/maheenr/3dgp_results';
folders={'swap_in_box_auto_new_floorOverlap_1'};


timeout=15*60;

for folder_no=1:numel(folders)
    folder=folders{folder_no};
    out_dir=fullfile(dir_parent,[folder '_html'],'list_files');
    if ~exist(out_dir,'dir')
        mkdir(out_dir);
    end
    
    im_names=dir(fullfile(dir_parent,folder));
    im_names=im_names(3:end);
    im_names={im_names(:).name};
    temp=cell(1,numel(im_names));
    errorLog_lists=struct('name',temp);
    
    matlabpool open
    parfor im_no=1:numel(im_names)
        im_no
        filename=fullfile(out_dir,[im_names{im_no} '.txt']);
        if exist(filename,'file')
            continue
        else
             fid_w=fopen(filename,'w');
        end
        
        im_no
        fid=fopen(fullfile(dir_parent,folder,im_names{im_no},'lists_and_scores.txt'));
        if fid<0
            continue
        end
        data=textscan(fid,'%s','delimiter','\n');
        data=data{1};
        fclose(fid);
        
                
        idx=find(strcmp('floor_overlap',data));
        overlap=data(idx+1:end);
        overlap=cell2mat(cellfun(@(x) str2num(x),overlap,'UniformOutput',0));
        
        thresh=0.01;
        overlap_bin=overlap<thresh;
        
        %clear some memory
        overlap=[];
        data=[];
                
        overlap_bin=sparse(overlap_bin);
        
        [lists,success]=getAllLists(triu(overlap_bin),timeout);
        if success~=-1
            errorLog_lists(im_no).name=im_names{im_no};
            errorLog_lists(im_no).list_no=success;
        end
            
        lists=cellfun(@(x) x-1,lists,'UniformOutput',0);
        
        fprintf(fid_w,'%d\n',numel(lists));
        fprintf(fid_w,'%s\n','C');
        for i=1:numel(lists)
            fprintf(fid_w,'%d\n',numel(lists{i}));
            for j=1:numel(lists{i})
                fprintf(fid_w,'%d\n',lists{i}(j));
            end
            fprintf(fid_w,'%s\n','C');
        end
        fclose(fid_w);
    end
    matlabpool close
    idx=~cellfun(@isempty,{errorLog_lists(:).name});
    errorLog_lists=errorLog_lists(idx);
    save(fullfile(out_dir,'errorLog_lists.mat'),'errorLog_lists');
end
