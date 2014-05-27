ccc
% sdada
dir_in='/lustre/maheenr/3dgp_results/swap_in_box_auto_new';
im_name='final_with_cube_floor.png';
dirs=dir(dir_in);
dirs=dirs(3:end);
dirs={dirs(:).name};
bool_incomplete=zeros(size(dirs));
for i=1:numel(dirs)
    filename=fullfile(dir_in,dirs{i},'renderings',im_name);
    if ~exist(filename,'file')
        bool_incomplete(i)=1;
    end
end

sum(bool_incomplete)
dirs_repeat=dirs(bool_incomplete);