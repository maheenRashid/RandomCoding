ccc

load record_threshes
load curves_data
temp=load('record_threshes_temp');
record_temp=temp.record_threshes;

figure; 
hold on;
% plot(record_threshes.recall_per_thresh_bef,record_threshes.prec_per_thresh_bef);
% plot(record_temp.recall_per_thresh_bef,record_temp.prec_per_thresh_bef,'-c');
% plot(record_threshes.prec_per_thresh_aft,record_threshes.recall_per_thresh_aft,'-c');

plot(pr_c_struct.dpm(2,:),pr_c_struct.dpm(1,:),'-r');
plot(pr_c_struct.nn_dpm(2,:),pr_c_struct.nn_dpm(1,:),'-g');
plot(pr_c_struct.nn_dpm_best(2,:),pr_c_struct.nn_dpm_best(1,:),'-b');
grid on;
axis equal;
xlim([0 1]);
ylim([0,1]);
xlabel('Recall');
ylabel('Precision');
l=legend({'DPM','NN_DPM','NN_DPM_BEST'});
set(l, 'Interpreter', 'none');


figure; 
hold on;
% plot(record_threshes.recall_per_thresh_bef,record_threshes.prec_per_thresh_bef);
% plot(record_temp.recall_per_thresh_bef,record_temp.prec_per_thresh_bef,'-c');
% plot(record_threshes.prec_per_thresh_aft,record_threshes.recall_per_thresh_aft,'-c');

plot(pr_c_struct.dpm(2,:),pr_c_struct.dpm(1,:),'-r');
plot(pr_c_struct.nn_dpm(2,:),pr_c_struct.nn_dpm(1,:),'-g');
% plot(pr_c_struct.nn_dpm_best(2,:),pr_c_struct.nn_dpm_best(1,:),'-b');
grid on;
axis equal;
xlim([0 1]);
ylim([0,1]);
xlabel('Recall');
ylabel('Precision');
l=legend({'DPM','NN_DPM'});
set(l, 'Interpreter', 'none');

load(fullfile('../../code_Knn_diversity/','perf_all'));
figure;hold on;
 plot(0.05:0.05:1,mean(perf_seq_opt_all,1),'-r'); 
  plot(0.05:0.05:1,mean(perf_rand_all,1),'-b'); 
  
l=legend({'Seq Opt Order','Random Order'});
xlabel('Percentage of Total Training Data');
ylabel('SSD difference between predicted and gt values');

