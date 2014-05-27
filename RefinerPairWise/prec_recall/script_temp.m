ccc

dir_parent='/lustre/maheenr/3dgp_results';
in_dir=fullfile(dir_parent,'swap_in_box_auto_floorOverlap_html','list_files');

models=dir(in_dir);
models={models(3:end).name};

bin_complete=zeros(size(models));
for i=1:numel(models)
    fprintf('%d\n',i);
    file_name=fullfile(in_dir,models{i});
    try
        fid=fopen(file_name);
        data=textscan(fid,'%s','delimiter','\n');
        data=data{1};
        fclose(fid);
        count=str2num(data{1});
        count_total=sum(strcmp('C',data));
        diff=count_total-count;
        if (diff==1)
            bin_complete(i)=1;
        end
    catch err
        continue;
    end
    
end

return
ccc
dir_parent='/lustre/maheenr/3dgp_results';
in_dir=fullfile(dir_parent,'swap_in_box_auto_floorOverlap');

models=dir(in_dir);
models={models(3:end).name};
% models=models(1:5);
bin_complete=zeros(size(models));
for i=1:numel(models)
    fprintf('%d\n',i);
    file_name=fullfile(in_dir,models{i},'lists_and_scores.txt');
    try
        fid=fopen(file_name);
        
        data=textscan(fid,'%s','delimiter','\n');
        data=data{1};
        fclose(fid);
        
        idx_cat=find(strcmp('cat_nos',data));
        num_cats=numel(str2num(data{idx_cat+1}));
        %         num_cats
        
        idx_floor=find(strcmp('floor_overlap',data));
        num_overlaps=numel(idx_floor+1:numel(data));
        %         num_overlaps
        
        if num_cats==num_overlaps
            bin_complete(i)=1;
        end
    catch err
        continue;
    end
    
end

