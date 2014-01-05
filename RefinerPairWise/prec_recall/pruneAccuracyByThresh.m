function [accu_prune]=pruneAccuracyByThresh(record_lists)
accu=record_lists.accuracy;
        accu=accu(record_lists.lists_thresh_bin);
        dpm_thresh_bin=record_lists.dpm_thresh_bin(2:end);
        accu_prune=cellfun(@(x) x(dpm_thresh_bin,:),accu,'UniformOutput',0);

end