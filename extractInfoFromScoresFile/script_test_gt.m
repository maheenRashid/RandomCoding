
for folder_no=1:numel(folders)
dir_results=[pre folders{folder_no}];
out_dir=[pre folders{folder_no} '_html'];
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end
names=getNamesFromDir(dir_results);

record_struct=struct;
errorLog=struct;

% load(fullfile(out_dir,'boxes_we_kept.mat'),'errorLog','record_struct');
matlabpool open
parfor i=1:numel(names)
    names{i}
    try
        fid=fopen(fullfile(dir_results,names{i},'scores_and_offsets.txt'));
        data=textscan(fid,'%s','delimiter','\n');
        fclose(fid);
        data=data{1};
        
        pred_score_org=data{2};
        pred_score_org=regexpi(pred_score_org,' ','split');
        pred_score_org=str2double(pred_score_org{end});
        
        data=data(4:end);
        [box_nos,keep_bool,score_infos,swap_infos]=getBestSwapPerBoxInfo(data,pred_score_org);
        [swap_infos_cmpAll,score_infos_cmpAll]=getKeepBoxIdsAndScores(data);
        
        
        
        record_struct(i).swap_infos=swap_infos;
        record_struct(i).keep_bool=keep_bool;
        record_struct(i).score_infos=score_infos;
        record_struct(i).swap_infos_cmpAll=swap_infos_cmpAll;
        record_struct(i).score_infos_cmpAll=score_infos_cmpAll;
        record_struct(i).names=names{i};
        
        
    catch err
        disp('error!');
        errorLog(i).name=names{i};
    end
%     save(fullfile(out_dir,'boxes_we_kept.mat'),'errorLog','record_struct');
end
matlabpool close;
save(fullfile(out_dir,'boxes_we_kept.mat'),'errorLog','record_struct');



record_cell=cell(6,numel(names));
errorLog=cell(1,0);
for i=1:numel(record_struct)
    if numel(record_struct(i).names)==0
        errorLog=[errorLog, names{i}];
        continue;
    end
    record_cell{1,i}=record_struct(i).swap_infos;
    record_cell{2,i}=record_struct(i).keep_bool;
    record_cell{3,i}=record_struct(i).score_infos;
    record_cell{4,i}=record_struct(i).swap_infos_cmpAll;
    record_cell{5,i}=record_struct(i).score_infos_cmpAll;
    record_cell{6,i}=record_struct(i).names;
    
end
save(fullfile(out_dir,'boxes_we_kept.mat'),'errorLog','record_struct','record_cell');

end

