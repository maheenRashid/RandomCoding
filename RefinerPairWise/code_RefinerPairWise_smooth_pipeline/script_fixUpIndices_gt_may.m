
cubes_ids={cubes_record(:).id};
for i=1:numel(boxes_rec_all)
fprintf('%d\n',i);    
box_rec=boxes_rec_all(i);
id=box_rec.id;

fname=fullfile(path_record_lists,[id '.mat']);

fname_split=regexpi(fname,'#','split');
fname_split=fname_split{end};
fname_split=fname_split(1:end-4);
cube_idx=find(strcmp(fname_split,cubes_ids));
cube_curr=cubes_record(cube_idx);

if exist(fname,'file')
    load(fname);
else
    fprintf('WHAT\n');
    continue;
end

box_to_keep=box_rec.box_to_keep_emp_check;

index_zeros=cube_curr.bin_zero_cube>0;

idx=find(~index_zeros);

box_to_keep_ac=idx(box_to_keep);

record_lists.idx_on_ground=(box_to_keep_ac-1)';
save(fullfile(path_record_lists,[id '.mat']),'record_lists');
end
