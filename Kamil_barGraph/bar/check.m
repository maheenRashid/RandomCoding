ccc

% Control and R0492-treated
% i am telling you that
% the control value is 29
% the R0492-treated is 43.667
% the Y-axis is Average number of isl-positive FBMNs
% and the standard devs are: control - 5.522
% and R0492-treated - 6.889
% write Control and R0492-treated on the x-axis next to the bars..

%   y = randn(3,4);         % random y values (3 groups of 4 parameters) 
%   erry = 0.1.*y;          % 10% error
%   h = barwitherr(erry, y);% plot with errorbars
% 
%   set(gca,'xticklabel',{'group a','group b','group c'})
%   legend('parameter 1','parameter 2','parameter 3','parameter 4')
%   ylabel('y value')
%   set(h(1),'facecolor','k');

%  bar(X,Y) draws the columns of the M-by-N matrix Y as M groups of N
%     vertical bars.  The vector X must not have duplicate values.

figure;
% h = bar('v6',[5,10],[29 43.667]);
% set(h(1),'facecolor','red') % use color name
% set(h(2),'facecolor',[0 1 0]) % or use RGB triple
x=[2,4];
y=[29;43.667];
std_dev=[5.522 6.889]
str={[0.5,0.5,0.5],[0.5,0.5,0.5]};
hold on
for i=1:2
h=bar(x(i),y(i));
set(h, 'FaceColor', str{i})
text(x(i),y(i),num2str(y(i),'%0.2f'),...
               'HorizontalAlignment','right',...
               'VerticalAlignment','bottom')
end
% grid on
xlim([0,6]);
hold on;
set(gca,'XTick',x) % This automatically sets 

errorbar(x,y,std_dev,'xk')


set(gca,'xticklabel',{'Control','R0492-treated'})
ylabel('Average number of isl-positive FBMNs');

