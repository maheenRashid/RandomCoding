ccc

load('lists_to_read_again.mat','rerun_struct','folder_lists','out_dir');

no_lines_all=rerun_struct(:).no_lines;
no_lines_all={rerun_struct(:).no_lines};
idx_to_rem=cellfun(@isempty,no_lines_all);
rerun_struct(idx_to_rem)=[];

no_lines_all=cell2mat(no_lines_all);
no_lists_all={rerun_struct(:).no_lists_read};
no_lists_all=cell2mat(no_lists_all);
no_lists_all=no_lists_all*2;
no_lines_all=no_lines_all-3;

idx_rerun=~(no_lines_all==no_lists_all);
ids_rerun={rerun_struct(:).id};
ids_rerun=ids_rerun(idx_rerun);

save('lists_to_read_again.mat','rerun_struct','folder_lists','out_dir','ids_rerun');


return

dir_parent='/home/maheenr/3dgp_results';
folder='swap_in_box_auto_new_listsScores_1';

folder_lists='swap_in_box_auto_new_listScores_1';

out_dir=fullfile(dir_parent,[folder '_html'],'record_lists');
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end

ids=dir(fullfile(dir_parent,folder_lists));
ids=ids(3:end);
ids={ids(:).name};

rerun_struct=struct('id',ids,'no_lines',cell(size(ids)),...
    'no_lists_read',cell(size(ids)));


matlabpool open;
parfor model_no=1:numel(ids)
    fprintf('%d\n',model_no);
    try
        id_curr=ids{model_no};
        out_file_name=fullfile(out_dir,[id_curr '.mat']);
        fname_lists=fullfile(dir_parent,folder_lists,id_curr,'scores_and_offsets.txt');
        str_sys=['cat ' fname_lists '| wc -l'];
        [~,no_lines]=system(str_sys);
        no_lines=str2num(no_lines);
        f_out=load(out_file_name);
        no_lists_read=numel(f_out.record_lists.lists);
        rerun_struct(model_no).no_lines=no_lines;
        rerun_struct(model_no).no_lists_read=no_lists_read;
    catch err
        fprintf('error %d %s\n',model_no,err.identifier);
        continue
    end
end
matlabpool close;

save('lists_to_read_again.mat','rerun_struct','folder_lists','out_dir');