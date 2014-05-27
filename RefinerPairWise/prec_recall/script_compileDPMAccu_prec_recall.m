
if ~exist(out_dir,'dir')
    mkdir(out_dir);
else
    return;
end

models=dir(fullfile(dir_result,'*.mat'));
models={models(:).name};

tmp=cell(1,numel(models));
prec_recall=struct('id',tmp,'dpm',tmp,'nn_dpm',tmp,'nn_dpm_best',tmp);

for model_no=1:numel(models)
    
fname=fullfile(dir_dpm_accu,models{model_no});
if ~exist(fname,'file')
    continue;
end
load(fname);
prec_recall(model_no)=getPrecRecallStruct(prec_recall(model_no),record_accuracy);
prec_recall(model_no).id=models{model_no};

end
out_file_name=fullfile(out_dir,'prec_recall_compiled');
save(out_file_name,'prec_recall');