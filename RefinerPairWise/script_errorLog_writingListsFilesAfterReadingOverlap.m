ccc

dir_parent='/home/maheenr/results_temp_09_13';
folders={'swapAllCombos_unique_10_auto_writeFloorOverlap',...
    'swapAllCombos_unique_10_gt_writeFloorOverlap'};

timeout=150*60;

for folder_no=1:numel(folders)
    folder=folders{folder_no};
    out_dir=fullfile(dir_parent,[folder '_html'],'list_files');
    load(fullfile(out_dir,'errorLog_lists.mat'),'errorLog_lists');
    im_names={errorLog_lists(:).name};
    
    for im_no=1:numel(im_names)
        filename=fullfile(out_dir,[im_names{im_no} '.txt']);
        delete(filename);
    end
    
    for im_no=1:numel(im_names)
        im_no
        filename=fullfile(out_dir,[im_names{im_no} '.txt']);
        if exist(filename,'file')
            continue
        else
             fid_w=fopen(filename,'w');
        end
        
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
        while true
            tic()
            [lists,success]=getAllLists(triu(overlap_bin),timeout);
            toc()
            if success<0
                break
            else
                timeout=2*timeout;
            end
            
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
    
end
