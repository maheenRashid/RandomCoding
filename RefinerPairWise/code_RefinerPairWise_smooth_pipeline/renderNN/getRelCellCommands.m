function [cc_curr,out_dirs]=getRelCellCommands(cellCommands,out_dir,mod_name,paths_nn_curr)

models_nn=cellfun(@(x) regexpi(x,'/','split'),paths_nn_curr,'UniformOutput',0);
models_nn=cellfun(@(x) x{end},models_nn,'UniformOutput',0);

models_nn_out=cellfun(@(x) regexpi(x,'[.]','split'),models_nn,'UniformOutput',0);
models_nn_out=cellfun(@(x) x{1},models_nn_out,'UniformOutput',0);

under_idx=cellfun(@(x) strfind(x,'_'),models_nn,'UniformOutput',0);
under_idx=cellfun(@(x) x(end),under_idx,'UniformOutput',0);

models_nn_to_find=cellfun(@(x,y) x(1:y-1),models_nn,under_idx,'UniformOutput',0);
models_nn_to_find=cellfun(@(x) strrep(x,'#','/'),models_nn_to_find,'UniformOutput',0);

append=cellfun(@(x,y) x(y+1:end),models_nn_out,under_idx,'UniformOutput',0);
% 
out_dirs=cellfun(@(x) fullfile(out_dir,mod_name,x),append,'UniformOutput',0);
% out_
cc_mod_name=cellfun(@(x) regexpi(x,' ','split'),cellCommands,'UniformOutput',0);
cc_mod_name=cellfun(@(x) x{2},cc_mod_name,'UniformOutput',0);
cc_idx=zeros(size(models_nn_to_find));
for i=1:numel(models_nn_to_find)
    cc_idx(i)=find(strcmp(models_nn_to_find{i},cc_mod_name));
end
% [~,~,cc_idx]=intersect(models_nn_to_find,cc_mod_name);
cc_curr=cellCommands(cc_idx);
end