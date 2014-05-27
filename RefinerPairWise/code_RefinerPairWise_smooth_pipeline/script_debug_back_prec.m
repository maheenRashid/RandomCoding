ccc

dir_parent='/lustre/maheenr/cube_per_cam_regenerate/room3D_gt/processing_lists';
dpm_pre='dpm_accu_per_mod_linReg_by_prec_withCat_noOrder_';
out_dir_pre='dpm_accu_compiled_per_cat_';
cat_no=1;
out_dir_pre=[out_dir_pre num2str(cat_no)];
% dirs=dir(fullfile(dir_parent,[out_dir_pre '*']));
% prec_recall_compiled_cell=cell(size(dirs));
% for i=1:numel(dirs)
%     out_dir=fullfile(dir_parent,dirs(i).name);
%     out_file_name=fullfile(out_dir,'prec_recall_compiled');
%         load(out_file_name,'prec_recall');
%     prec_recall_compiled_cell{i}=prec_recall;
% end

load('for_debug.mat');

prec_recall_temp=prec_recall_compiled_cell{1};
num_prec=numel(prec_recall_compiled_cell);

ids={prec_recall_temp(:).id};
model_no_perf=struct('id',ids,'prec_recall',cell(size(ids)));
for model_no=1:numel(ids)
    id=ids{model_no};
    prec_recall_cell=cell(num_prec,1);
    for prec_no=1:num_prec
        prec_curr=prec_recall_compiled_cell{prec_no};
        ids_prec={prec_curr(:).id};
        idx=find(strcmp(id,ids_prec));
        prec_curr=prec_curr(idx);
        prec_recall_cell{prec_no}=prec_curr;
    end
    prec_curr=prec_recall_cell;
    nn_dpm=cellfun(@(x) x.nn_dpm,prec_curr,'UniformOutput',0);
    nn_dpm_prec=cellfun(@(x) x(1)/x(2),nn_dpm);
    nn_dpm_recall=cellfun(@(x) x(3)/x(4),nn_dpm);
    
    nn_dpm_prec(isnan(nn_dpm_prec))=1;
    
    model_no_perf(model_no).nn_dpm_prec=nn_dpm_prec;
    model_no_perf(model_no).nn_dpm_recall=nn_dpm_recall;
    model_no_perf(model_no).prec_recall=prec_recall_cell;
end

recall_all=[model_no_perf(:).nn_dpm_recall];
recall_all(isnan(recall_all))=0;
avgs=mean(recall_all,2);
[max_val,max_idx]=max(avgs);

row_1=recall_all(1,:);
row_2=recall_all(max_idx,:);
idx_prob=find(row_2>row_1);
id=model_no_perf(idx_prob(1)).id

