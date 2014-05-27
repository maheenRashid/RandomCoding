    matlabpool open;
    parfor i=1:numel(names)
        x=load(fullfile(in_dir,names{i}));
        filename=fullfile(out_dir,[x.record_box_info_all.id '.txt']);
        writeTopNFileFromStruct(filename,x.record_box_info_all,1);
    end
    matlabpool close;
