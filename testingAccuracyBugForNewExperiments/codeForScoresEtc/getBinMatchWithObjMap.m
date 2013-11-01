function [bin_match,bin_dpm_curr_sort]=getBinMatchWithObjMap(bin_dpm_curr_sort,bin_dpm_obj_map,cmp_kept_bin)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here

ids_we_got_right=unique(bin_dpm_obj_map(bin_dpm_curr_sort==cmp_kept_bin & bin_dpm_curr_sort>0));

for i=ids_we_got_right'
    k=bin_dpm_obj_map==i;
    j=cmp_kept_bin==bin_dpm_curr_sort;
    bin_dpm_curr_sort(~j & k)=0;
end

bin_match=bin_dpm_curr_sort==cmp_kept_bin;

end

