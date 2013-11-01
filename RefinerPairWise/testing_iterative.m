ccc

bin=zeros(7);
bin(1,4)=1;
bin(1,6)=1;
bin(1,7)=1;
bin(3,4)=1;
bin(4,1)=1;
bin(4,3)=1;
bin(4,5)=1;
bin(4,6)=1;
bin(4,7)=1;
bin(5,4)=1;
bin(5,6)=1;
bin(6,1)=1;
bin(6,4)=1;
bin(6,5)=1;
bin(6,7)=1;
bin(7,1)=1;
bin(7,4)=1;
bin(7,6)=1;


load('overlap_bin.mat')
% overlap_bin=overlap_bin';
% bin=overlap_bin(1:100,1:100);
bin=overlap_bin;


% tic()
% lists_it=getAllLists_it(bin);
% toc();

t_out=15*60;

bin=bin>0;
tic()
[lists_u,success]=getAllLists(triu(bin),t_out);
toc()

% tic()
% lists=getAllLists(bin,30);
% toc()


% disp('isequal_lists(lists_u,lists)')
% 
% isEqual_lists(lists_u,lists)

disp('isequal_lists(lists_it,lists)');

isEqual_lists(lists_it,lists_u)

