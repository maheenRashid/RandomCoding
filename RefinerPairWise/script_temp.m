% ccc
% 
% load('record_box_info_all.mat')
filename=fullfile('temp_top2.txt');
n=2;
i=1;
record_temp=getTopNFromFileStruct(n,record_box_info_all(i));
writeTopNFileFromStruct(filename,record_temp);
