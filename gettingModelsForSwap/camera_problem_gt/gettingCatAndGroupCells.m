clear; close all;clc;
load('record_new_labels_bad_names_in.mat','record_new_labels');

group_dir='/home/maheenr/AWS-DATA/data/shared_payload/annotated_models/skp_groupings';
cat_dir='/home/maheenr/dataNew/skp_category_new_GT/';
dirs={group_dir,cat_dir};
record_new_labels=record_new_labels(~cellfun(@isempty,{record_new_labels(1:end).name}));

for mod_no=1:numel(record_new_labels)
    id_curr=record_new_labels(mod_no).name;
    
    cell_data=cell(1,2);
    for i=1:2
        fid=fopen(fullfile(dirs{i},[id_curr '.txt']));
        if fid==-1
            keyboard
        end
        data=textscan(fid,'%s','delimiter','\n');
        fclose(fid);
        data=data{1};
        try
            data=cellfun(@str2num,data);
            cell_data{i}=data;
        catch err
            cell_data{i}=[];
        end
    end
    
    record_new_labels(mod_no).cat_no_all=cell_data{2};
    record_new_labels(mod_no).group_id_all=cell_data{1};
    
end

save('record_new_labels_bad_names_in_file_data.mat','record_new_labels');
