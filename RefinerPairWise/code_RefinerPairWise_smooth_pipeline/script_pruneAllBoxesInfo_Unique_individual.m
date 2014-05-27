    
    matlabpool open;
    parfor i=1:numel(names)
        fprintf('%d\n',i);
        x=load(fullfile(in_dir,names{i}));
        record_box_info_all=getTopNFromFileStruct_UniqueScores(n,x.record_box_info_all);
        out_file_name=fullfile(out_dir,names{i});
        parsave_name(out_file_name,record_box_info_all,'record_box_info_all');
    end
    matlabpool close;

