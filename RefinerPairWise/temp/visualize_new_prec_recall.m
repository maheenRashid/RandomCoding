ccc
new=load('new_new.mat');
old=load('gt_newest.mat');

figure;
hold on;
plot(new.pr_c_struct.nn_dpm(2,:),new.pr_c_struct.nn_dpm(1,:),'-r','linewidth',2);
plot(new.pr_c_struct.nn_dpm_best(2,:),new.pr_c_struct.nn_dpm_best(1,:),'-g','linewidth',2);
plot(new.pr_c_struct.dpm(2,:),new.pr_c_struct.dpm(1,:),'-b','linewidth',2);


plot(old.pr_c_struct.nn_dpm(2,:),old.pr_c_struct.nn_dpm(1,:),'-c','linewidth',2);
plot(old.pr_c_struct.nn_dpm_best(2,:),old.pr_c_struct.nn_dpm_best(1,:),'-y','linewidth',2);
% plot(old.pr_c_struct.dpm(2,:),old.pr_c_struct.dpm(1,:),'-m','linewidth',2);

% l=legend('new_pred','new_best','new_dpm','old_pred','old_best','old_dpm');
l=legend('gt_pred','gt_best','gt_dpm','auto_pred','auto_best');
% ,'old_dpm');

col={'*r','*g','*b','*c','*y','*m'};
type={'nn_dpm','nn_dpm_best','dpm'};
temp={new,old};
col_no=1;
ap_all=zeros(1,0);
for i=1:2
    for j=1:numel(type)
        prec=eval(['temp{i}.pr_c_struct.' type{j} '(1,:)']);
        recall=eval(['temp{i}.pr_c_struct.' type{j} '(2,:)']);
        ap=getAP(prec,recall);
        ap_all=[ap_all,ap];
        plot(ap,ap,col{col_no},'markersize',4,'linewidth',2);
        col_no=col_no+1;
        
        
    end
end

grid on;
xlim([0,1]);
ylim([0,1]);
set(l,'interpreter','none');
% ,'linewidth',2);

