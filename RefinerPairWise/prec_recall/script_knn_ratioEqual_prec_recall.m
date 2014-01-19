
%get model names
models=dir(fullfile(dir_in,'*.mat'));

%check for whether the previous stage has completed
bytes_all=[models(:).bytes];
models(bytes_all<200)=[];

%get names
models={models(:).name};
models=cellfun(@(x) x(1:end-4),models,'UniformOutput',0);


%create directory for output
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end


matlabpool open;
parfor model_no=1:numel(models)
    model_no
    out_file_name=fullfile(out_dir,[models{model_no} '.mat']);
    temp=load(fullfile(dir_in,models{model_no}));
    record_lists=temp.record_lists;
    if isnan(k)
        record_lists=getDistanceAllPoints(record_lists);
        parsave(out_file_name,record_lists);
    else
        record_lists=getNNByPercentageK(record_lists,k);
        parsave(out_file_name,record_lists);
    end
end

matlabpool close;



