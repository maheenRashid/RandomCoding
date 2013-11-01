ccc
load('record_labelMe.mat');

labels_to_extract={'chair','side','drawer'};
record_labels_to_extract=cell(1,numel(labels_to_extract));


for i=1:numel(labels_to_extract)

[record_objects_curr,idx_curr]=getIdxOfLabel(record_labelMe,labels_to_extract{i});

record_objects_curr=record_objects_curr(:,idx_curr);
record_labels_to_extract{i}=record_objects_curr;

end

load('record_labelMe_scott.mat');

labels_to_rep={'chair','ns','ns'};

for i=1:numel(record_labels_to_extract)
    record_labels_curr=record_labels_to_extract{i};
    for name_no=1:size(record_labels_curr,2)
        bin=strcmp(record_labels_curr{1,name_no},record_labelMe(1,:));
        if sum(bin)==0
            continue
        end
        if sum(bin)~=1
            keyboard;
        end
        idx=find(bin);
        objects_to_add=record_labels_curr{2,name_no};
        [objects_to_add{1,:}]=deal(labels_to_rep{i});
        if numel(record_labelMe{2,idx})==1
            record_labelMe{2,idx}=objects_to_add;
        else
            record_labelMe{2,idx}=[record_labelMe{2,idx},objects_to_add];
        end
%         keyboard;
    end
    
end

save('record_labelMe_combined.mat','record_labelMe');


