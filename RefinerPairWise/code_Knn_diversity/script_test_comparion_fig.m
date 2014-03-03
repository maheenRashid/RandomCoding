ccc


x=load ('curves_data');
div_str=x.compiled_dirs;
div_str=cellfun(@(x) regexpi(x,'_','split'),div_str,'UniformOutput',0);
div_str=cellfun(@(x) x{end},div_str,'UniformOutput',0);

nn_dpm=x.pr_c_struct.nn_dpm;
nn_dpm_best=x.pr_c_struct.nn_dpm_best;
dpm=x.pr_c_struct.dpm;



clr=cellfun(@(x) str2double(x)*[1,0,0],div_str,'UniformOutput',0);
clr=cell2mat(clr');

clr_best=cellfun(@(x) str2double(x)*[0,0,1],div_str,'UniformOutput',0);
clr_best=cell2mat(clr_best');

y=load('curves_data_no_div.mat');
nn_dpm_comp=y.pr_c_struct.nn_dpm;
nn_dpm_comp=nn_dpm_comp(:,1);
nn_dpm_comp_best=y.pr_c_struct.nn_dpm_best(:,1);

figure;
hold on;
gscatter(nn_dpm(2,:),nn_dpm(1,:),1:numel(nn_dpm(1,:)),clr);
gscatter(nn_dpm_comp(2,:),nn_dpm_comp(1,:),1,'g','*');
l=legend([div_str,'no_div'],'Location','NorthEastOutside');
set(l,'interpreter','none');
xlabel('Recall');
ylabel('Precision');
grid on;





