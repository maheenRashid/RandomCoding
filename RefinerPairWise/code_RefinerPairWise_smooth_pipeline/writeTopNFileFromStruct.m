function writeTopNFileFromStruct(filename,record,keepNothing)

if nargin<3
    keepNothing=0;
end

boxes=record.swap_info;
if keepNothing==0
    idx=pruneDetWorseThanNothing(record);
    boxes=boxes(idx,:);
end 


fid=fopen(filename,'w');
fprintf(fid,'%d\n',size(boxes,1));
for box_no=1:size(boxes,1)
    for val_no=1:size(boxes,2)
        fprintf(fid,'%d\n',boxes(box_no,val_no));
    end
    fprintf(fid,'%s\n','C');
end
fclose(fid);

end


function idx=pruneDetWorseThanNothing(record)
    box_ids=record.box_ids;
    pred_scores=record.pred_scores;
    idx_nothing=box_ids==-1;
    pred_nothing=pred_scores(idx_nothing);
    idx=find(pred_scores>pred_nothing);

end