if ~exist(out_dir,'dir')
    mkdir(out_dir);
end
    
pr_c_cell=cell(1,numel(compiled_dirs));
for in_dir_no=1:numel(pr_c_cell)
    in_dir_curr=compiled_dirs{in_dir_no};
    mat_name=dir(fullfile(in_dir_curr,'*.mat'));
    load(fullfile(in_dir_curr,mat_name(1).name));
    pr_c_cell{in_dir_no}=getPrecRecallCompiled(prec_recall);
end


names=fieldnames(prec_recall);
names=names(2:end);
% temp=cell(1,numel(names));
pr_c_struct=struct();
for i=1:numel(names)
    temp=cell2mat(cellfun(@(x) x(:,i),pr_c_cell,'UniformOutput',0));
    pr_c_struct=setfield(pr_c_struct,names{i},temp);
end

save(fullfile(out_dir,'curves_data'),'pr_c_struct','compiled_dirs');

names=fieldnames(prec_recall);
names=names(2:end);
% temp=cell(1,numel(names));
pr_c_struct=struct();
for i=1:numel(names)
    temp=cell2mat(cellfun(@(x) x(:,i),pr_c_cell,'UniformOutput',0));
    if i==1
        mat_xy=zeros(numel(names),size(temp,2),2);
    end
    
    
    pr_c_struct=setfield(pr_c_struct,names{i},temp);
    for j=1:2
        mat_xy(i,:,j)=temp(j,:);
    end
end

h=figure;
plot(mat_xy(1:2,:,2)',mat_xy(1:2,:,1)');
grid on;
axis equal;
xlim([0 1]);
ylim([0,1]);
l=legend(names);
set(l, 'Interpreter', 'none');

saveas(h,fullfile(out_dir,'prec_recall_curves.png'));