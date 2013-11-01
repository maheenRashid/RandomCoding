ccc
load('accuracy_cell_auto.mat');
accu_mat=zeros(3,3);
 
for i=1:3

bin_all=accuracy_cell(i,:)';
bin_all=cell2mat(bin_all);

accu_crude=sum(bin_all(:,1))/numel(bin_all(:,1));
labs=[0,1];
for bsr_no=1:numel(labs)
    correct=sum(bin_all(bin_all(:,2)==labs(bsr_no),1));
    total=sum(bin_all(:,2)==labs(bsr_no));
    bsr=correct/total;
    accu_mat(bsr_no,i)=bsr;
end

accu_mat(3,i)=accu_crude;


end

accu_mat
figure;
 bar(accu_mat')
 title('DPM Auto Layout');
 
 set(gca,'XTickLabel',{'Compare All Sorted',...
    'Compare With Walls','Keep On Ground'})
hleg1=legend('Over all Accuracy','Positive Correct','Negative Correct');
set(hleg1,'Location','NorthEast')

 
clear;
 load('accuracy_cell_gt.mat');
accu_mat=zeros(3,3);

for i=1:3

bin_all=accuracy_cell(i,:)';
bin_all=cell2mat(bin_all);

accu_crude=sum(bin_all(:,1))/numel(bin_all(:,1));
labs=[0,1];
for bsr_no=1:numel(labs)
    correct=sum(bin_all(bin_all(:,2)==labs(bsr_no),1));
    total=sum(bin_all(:,2)==labs(bsr_no));
    bsr=correct/total;
    accu_mat(bsr_no,i)=bsr;
end

accu_mat(3,i)=accu_crude;


end

accu_mat
figure;
 bar(accu_mat')
 title('DPM GT Layout');
 
 set(gca,'XTickLabel',{'Compare All Sorted',...
    'Compare With Walls','Keep On Ground'})
hleg1=legend('Over all Accuracy','Positive Correct','Negative Correct');
set(hleg1,'Location','NorthEast')
 
