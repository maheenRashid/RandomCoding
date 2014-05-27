function [dets_all,error_files]=getResponse_noWeight(dir_in,models)



dets_all=cell(1,numel(models));
% ('det_all',dummy);
error_files=cell(size(models));

matlabpool open;
parfor i=1:numel(models)
%     fprintf('%d\n',i);
    try
        temp=load(fullfile(dir_in,models{i}));
        record_lists=temp.record_lists;
        accu=record_lists.accuracy;
        if isfield(record_lists,'dpm_thresh_bin')
            accu=pruneAccuracyByThresh(record_lists);
        end
        dets_all{i}=accu;
    catch err
        fprintf('error\n');
        error_files{i}=err.identifier;
    end
end
matlabpool close;

dets_all(cellfun(@isempty,dets_all))={{zeros(0,3)}};

end
