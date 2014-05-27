ccc

dir_parent='/lustre/maheenr/3dgp_results';
in_dir=fullfile(dir_parent,'swap_in_box_auto_floorOverlap');
names=dir(in_dir);
names={names(3:end).name};
names=names(1);
out_dir=fullfile([in_dir '_html'],'list_files_3');
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end

script_writeListFiles_may;