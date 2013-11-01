ccc
dir_skp='E:/gt_skp';

skp_files=dir(fullfile(dir_skp,'*.txt'));

fileno=1;
fname=fullfile(dir_skp,skp_files(fileno).name);

% fname=

fid=fopen(fname);
data=textscan(fid,'%s','delimiter','\n');
data=data{1};
fclose(fid);

ptr=1;
numComps=str2double(data{ptr});
A=cell(1,numComps);
ptr=ptr+1;

for comp_no=1:numComps
curr_comp=cell(1,str2double(data{ptr})*2);
ptr=ptr+1;
for faceNo=1:2:numel(curr_comp)
num_pts=str2double(data{ptr});
pts=cellfun(@str2num,data(ptr+1:ptr+num_pts));
pts=reshape(pts,3,[]);
pts=pts';
ptr=ptr+num_pts+2;
num_polygons=str2double(data{ptr});
polygons=cellfun(@str2num,data(ptr+1:ptr+num_polygons));
polygons=reshape(polygons,3,[]);
curr_comp{faceNo}=pts;
curr_comp{faceNo+1}=polygons;
ptr=ptr+num_polygons+2;
end
A{comp_no}=curr_comp;
end

% 
%             for i=1:size(pointsTrans,1)
%                 fprintf(f,'%4.5f\n',pointsTrans(i,1));
%                 fprintf(f,'%4.5f\n',pointsTrans(i,2));
%                 fprintf(f,'%4.5f\n',pointsTrans(i,3));
%             end
%             fprintf(f,'C\n');
% 



% f=fopen(fullfile('maheen_cornerPlacement',strcat(name,'.txt')),'w');% dump file to be read into opengl cpp
% 
%     fprintf(f,'%d\n',length(A)-1);
%     for compsIndex=1:length(A)-1;
%         fprintf(f,'%d\n',(length(A{compsIndex})-1)/2);
%         for facesIndex = 1:2:size(A{compsIndex},2)-1
%             pointsTrans = A{compsIndex}{facesIndex};
%             polygons = abs(A{compsIndex}{facesIndex+1})';
%             fprintf(f,'%d\n',size(pointsTrans,1)*3);
%             for i=1:size(pointsTrans,1)
%                 fprintf(f,'%4.5f\n',pointsTrans(i,1));
%                 fprintf(f,'%4.5f\n',pointsTrans(i,2));
%                 fprintf(f,'%4.5f\n',pointsTrans(i,3));
%             end
%             fprintf(f,'C\n');
%             fprintf(f,'%d\n',size(polygons,1)*3);
%             for i=1:size(polygons,1)
%                 fprintf(f,'%d\n',polygons(i,:));
%             end
%             fprintf(f,'C\n');
%         end
%         fseek(f,-1,0);
%         if compsIndex==length(A)-1
%             fprintf(f,'Z');
%         else
%             fprintf(f,'Z\n');
%         end
%     end
%     fclose(f);
% 
% 
