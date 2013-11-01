

load(fullfile(out_dir,'bad_names.mat'),'bad_names');
load(fullfile(out_dir,'record_new_labels.mat'),'record_new_labels');

group_dir='/home/maheenr/AWS-DATA/data/shared_payload/annotated_models/skp_groupings';
cat_dir='/home/maheenr/dataNew/skp_category_correct';
dirs={group_dir,cat_dir};


record_new_labels=record_new_labels(~cellfun(@isempty,{record_new_labels(1:end).name}));

record_bad_names=struct();
for bad_no=1:numel(bad_names)
    id_curr=bad_names{bad_no};
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
    
    if ~isempty(cell_data{1})
        if numel(cell_data{1})~=numel(unique(cell_data{1}))
            [group_ids_temp,idx]=unique(cell_data{1});
            cell_data{1}=group_ids_temp;
            cell_data{2}=cell_data{2}(idx);
        end
    end
    record_bad_names(bad_no).name=id_curr;
    record_bad_names(bad_no).cat_no_aft=cell_data{2};
    record_bad_names(bad_no).group_ids=cell_data{1};
end

record_new_labels=[record_new_labels record_bad_names];


save(fullfile(out_dir,'record_new_labels.mat'),'record_new_labels');
