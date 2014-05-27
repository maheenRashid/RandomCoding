ccc

% obj_no=15;
obj_no=2;
rot_nos=[1,2,3,4]';
boxes=zeros(obj_no*numel(rot_nos),1);
a=ones(4,obj_no);
% a_m=1:obj_no;
a_m=[282,1];
a=bsxfun(@times,a,a_m);
rots=repmat(rot_nos,obj_no,1);
boxes(:,2)=4;
boxes(:,3)=1;
boxes(:,4)=rots(:);
boxes(:,5)=a(:)-1;


filename='best_swap_for_fig.txt';
fid=fopen(filename,'w');
fprintf(fid,'%d\n',size(boxes,1));
for box_no=1:size(boxes,1)
    for val_no=1:size(boxes,2)
        fprintf(fid,'%d\n',boxes(box_no,val_no));
    end
    fprintf(fid,'%s\n','C');
end
fclose(fid);

lists=0:size(boxes,1)-1;
lists=num2cell(lists);
filename='lists_for_fig.txt';


    fid_w=fopen(filename,'w');
    fprintf(fid_w,'%d\n',numel(lists));
    fprintf(fid_w,'%s\n','C');
    for i=1:numel(lists)
        fprintf(fid_w,'%d\n',numel(lists{i}));
        for j=1:numel(lists{i})
            fprintf(fid_w,'%d\n',lists{i}(j));
        end
        fprintf(fid_w,'%s\n','C');
    end
    fclose(fid_w);

