ccc

fid=fopen('annotated_model_list.txt');
data=textscan(fid,'%s','delimiter','\n');
data=data{1};
fclose(fid);
fid=fopen('annotated_models.txt','w');
for i=1:numel(data)
    model_curr=data{i};
    model_curr=regexpi(model_curr,'[.]','split');
    model_curr=model_curr{1};
    model_curr=strrep(model_curr,'#','/');
    fprintf(fid,'%s\n',model_curr);
    

end
fclose(fid);
