ccc

in_dir='/lustre/maheenr/cube_per_cam_regenerate/room3D_gt/processing_lists_noprune_noNeg_all';
% accu_dir='dpm_accu_per_mod_linReg_varyingRatio_by_prec_withCat_noOrder_0.44976';
list_dir='record_lists';
% res_dir='results_linReg_LOO_varyingRatio_by_prec_withCat_noOrder_0.44976';
mod_name='b#bedroom#sun_abiprszvibrmonrm';

% accu=load(fullfile(in_dir,accu_dir,[mod_name '.mat']));
list=load(fullfile(in_dir,list_dir,[mod_name '.mat']));
% res=load(fullfile(in_dir,res_dir,[mod_name '.mat']));



return
ccc

in_dir='/lustre/maheenr/cube_per_cam_regenerate/room3D_auto/swap_in_box';

dirs=dir(in_dir);
dirs={dirs(3:end).name};
bin=zeros(size(dirs));
for i=1:numel(dirs)
    filename=fullfile(in_dir,dirs{i},'renderings','final_with_cube_normal.png');
    bin(i)=exist(filename,'file');
end

return
ccc

in_dir='/lustre/maheenr/cube_per_cam_regenerate/room3D_gt/swap_in_box';
out_dir='/lustre/maheenr/cube_per_cam_regenerate/room3D_gt/record_box_info_all';
ims=dir(in_dir);
ims={ims(3:end).name};

names=ims;
equality=zeros(size(ims));
matlabpool open;
parfor i=1:numel(names)
    fprintf('%d\n',i);
    fid=fopen(fullfile(in_dir,names{i},'scores_and_offsets.txt'));
        data=textscan(fid,'%s','delimiter','\n');
        fclose(fid);
        data=data{1};
        [box_ids,swap_info,pred_scores,gt_scores]=getSwapAndScoreInfoAll(data);
        out_file_name=fullfile(out_dir,[names{i} '.mat']);
        check=load(fullfile(out_file_name));
        equality(i)=isequal(gt_scores,check.record_box_info_all.gt_scores);
   
end
matlabpool close;
problems=find(equality<1);
names(problems)

return
last_line=cell(size(ims));
matlabpool open;
parfor im_no=1:numel(ims)
    fid=fopen(fullfile(in_dir,ims{im_no},'scores_and_offsets.txt'));
    data=textscan(fid,'%s','delimiter','\n');
    data=data{1};
    fclose(fid);
    last_line{im_no}=data{end};
end
matlabpool close;

problems=find(cellfun(@isempty,strfind(last_line,'After Keep box')));
ims(problems)
