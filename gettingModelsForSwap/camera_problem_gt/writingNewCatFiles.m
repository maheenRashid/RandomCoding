ccc

out_dir=('skp_category_correct');
if ~exist(out_dir)
    mkdir(out_dir);
end

load('record_new_labels_with_new_cat.mat','record_new_labels');

for mod_no=1:numel(record_new_labels)
    id=record_new_labels(mod_no).name;
    new_cat=record_new_labels(mod_no).new_cat_all;
    
    fid=fopen(fullfile(out_dir,[id '.txt']),'w');
    for cat_no=1:numel(new_cat)
        fprintf(fid,'%s\n',num2str(new_cat(cat_no)));
    end
    fclose(fid);

end