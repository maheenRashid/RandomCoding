function parsave_name(out_file_name,struct,struct_name)
    evalc([struct_name '=struct']);
    save(out_file_name,struct_name);
end