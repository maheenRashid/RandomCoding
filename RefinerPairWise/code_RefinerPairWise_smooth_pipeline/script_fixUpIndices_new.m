ccc

dir_parent='/home/maheenr/3dgp_results';
folder='swap_in_box_auto_new_listsScores_1';
path_record_lists=fullfile(dir_parent,[folder '_html'],'record_lists');

path_box_rec='/lustre/maheenr/new_3dgp/indoorunderstanding_3dgp-master';

load(fullfile(path_box_rec,'boxes_rec_all_new.mat'));
load(fullfile(path_box_rec,'cubes_record_new.mat'));
load('lists_to_read_again.mat','ids_rerun');


% return
cubes_ids={cubes_record(:).id};
for i=1:numel(boxes_rec_all)
    
box_rec=boxes_rec_all(i);
id=box_rec.id;

id_rerun_check=strcmp(id,ids_rerun);
if sum(id_rerun_check)==0
    continue;
end
i
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
% return
% check=reshape(box_rec.box_no(2:end),27,[]);
% [x,y]=ind2sub(size(check),ind);
% box_to_keep=y;



% index_zeros=reshape(cube_curr.bin_zero_cube,27,[]);
% index_zeros=sum(index_zeros,1);
index_zeros=cube_curr.bin_zero_cube>0;

idx=find(~index_zeros);
box_to_keep_ac=idx(box_to_keep);

record_lists.idx_on_ground=(box_to_keep_ac-1)';
% return
save(fullfile(path_record_lists,[id '.mat']),'record_lists');
% return
end
