ccc

load('errorLog_lists.mat');

lists_cell={errorLog_lists(:).lists};
lists_u_cell={errorLog_lists(:).lists_u};

bin_mat=zeros(size(lists_u_cell));
for i=1:numel(lists_u_cell)
    bin_mat(i)=isEqual_lists(lists_cell{i},lists_u_cell{i});
end


return
ccc


dir_parent='/home/maheenr/results_temp_09_13';
folders={'swapAllCombos_unique_10_auto_writeFloorOverlap',...
    'swapAllCombos_unique_10_gt_writeFloorOverlap'};


timeout=5*60;

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
    parfor im_no=1:17
%         numel(im_names)
        
%         filename=fullfile(out_dir,[im_names{im_no} '.txt']);
%         if exist(filename,'file')
%             continue
%         end
        
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
        
        tStart = tic;   
        [lists,success]=getAllLists(overlap_bin,timeout);
        et = toc(tStart); 

        tStart = tic;   
        [lists_u,success_u]=getAllLists(triu(overlap_bin),timeout);
        et_u = toc(tStart); 

        
            errorLog_lists(im_no).name=im_names{im_no};
            errorLog_lists(im_no).lists=lists;
            errorLog_lists(im_no).lists_u=lists_u;
            errorLog_lists(im_no).success=success;
            errorLog_lists(im_no).success_u=success_u;
            errorLog_lists(im_no).et=et;
            errorLog_lists(im_no).et_u=et_u;
%             
%         lists=cellfun(@(x) x-1,lists,'UniformOutput',0);
%         
%         fid=fopen(filename,'w');
%         fprintf(fid,'%d\n',numel(lists));
%         fprintf(fid,'%s\n','C');
%         for i=1:numel(lists)
%             fprintf(fid,'%d\n',numel(lists{i}));
%             for j=1:numel(lists{i})
%                 fprintf(fid,'%d\n',lists{i}(j));
%             end
%             fprintf(fid,'%s\n','C');
%         end
%         fclose(fid);
    end
    matlabpool close
    idx=~cellfun(@isempty,{errorLog_lists(:).name});
    errorLog_lists=errorLog_lists(idx);
    save(fullfile(out_dir,'errorLog_lists.mat'),'errorLog_lists');
end
