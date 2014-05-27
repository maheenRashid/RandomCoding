ccc

dir_parent='/home/maheenr/3dgp_results';
folder='swap_in_box_auto_listsScores_1';
path_record_lists=fullfile(dir_parent,[folder '_html'],'record_lists');

path_box_rec='/lustre/maheenr/new_3dgp/indoorunderstanding_3dgp-master';

load(fullfile(path_box_rec,'boxes_rec_all'));
load(fullfile(path_box_rec,'cubes_record'));
cubes_ids={cubes_record(:).id};
for i=1:8
%     9:numel(boxes_rec_all)
    i
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

ind=box_rec.box_to_keep_emp_check;
check=reshape(box_rec.box_no(2:end),27,[]);
[x,y]=ind2sub(size(check),ind);
box_to_keep=y;



index_zeros=reshape(cube_curr.bin_zero_cube,27,[]);
index_zeros=sum(index_zeros,1);
index_zeros=index_zeros>0;

idx=find(~index_zeros);
box_to_keep_ac=idx(box_to_keep);

record_lists.idx_on_ground=(box_to_keep_ac-1)';

save(fullfile(path_record_lists,[id '.mat']),'record_lists');
% return
end
