ccc

dir_parent='/lustre/maheenr/results_temp_09_13';
dir_meta=fullfile(dir_parent,'swapAllCombos_unique_3_gt_writeAndScoreLists_html');


k_vec=[0.01:0.01:0.1,0.2:0.1:1];

for k=k_vec
    find(k==k_vec)
    out_dir_meta=fullfile(dir_meta,['KNN_' num2str(k) '_LOO_ratioEqual']);
    in_dir_k=fullfile(out_dir_meta,'prec_recall_curves_mat_images_by_prec_withCat');
    out_dir=fullfile(out_dir_meta,'prec_recall_curves_mat_images_by_prec_withCat_diversity');
    x=load (fullfile(out_dir,'curves_data.mat'));
    div_str=x.compiled_dirs;
    div_str=cellfun(@(x) regexpi(x,'_','split'),div_str,'UniformOutput',0);
    div_str=cellfun(@(x) x{end},div_str,'UniformOutput',0);
    
    nn_dpm=x.pr_c_struct.nn_dpm;
    nn_dpm_best=x.pr_c_struct.nn_dpm_best;
    dpm=x.pr_c_struct.dpm;
    
    clr=cellfun(@(x) str2double(x)*[1,0,0],div_str,'UniformOutput',0);
    clr=cell2mat(clr');
    
    y=load(fullfile(in_dir_k,'curves_data.mat'));
    nn_dpm_comp=y.pr_c_struct.nn_dpm;
    nn_dpm_comp=nn_dpm_comp(:,1);
    
    h=figure;
    hold on;
    gscatter(nn_dpm(2,:),nn_dpm(1,:),1:numel(nn_dpm(1,:)),clr);
    gscatter(nn_dpm_comp(2,:),nn_dpm_comp(1,:),1,'g','*');
    l=legend([div_str,'no_div'],'Location','NorthEastOutside');
    set(l,'interpreter','none');
    xlabel('Recall');
    ylabel('Precision');
    grid on;
    
    saveas(h,fullfile(out_dir,'prec_recall_0.10109_comp_1.png'));
    
    h=figure;
    hold on;
    gscatter(nn_dpm(2,:),nn_dpm(1,:),1:numel(nn_dpm(1,:)),clr);
    
    l=legend([div_str],'Location','NorthEastOutside');
    set(l,'interpreter','none');
    xlabel('Recall');
    ylabel('Precision');
    grid on;

    saveas(h,fullfile(out_dir,'prec_recall_0.10109_comp.png'));
    close all;
    
end


