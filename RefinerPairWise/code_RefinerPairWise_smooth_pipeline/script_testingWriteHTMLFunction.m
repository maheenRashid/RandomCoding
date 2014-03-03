ccc

for div_no=[0.05,0.5,1]
prctile_str=['by_prec_withCat_0.10109_diversity_' num2str(div_no) '_question'];
% prctile_str='by_prec_withCat_0.10109'
for k_no=0.01
%     [0.01:0.01:0.09]
    out_dir_rendering=['K_' num2str(k_no) '_' prctile_str];
    params.dir_model=out_dir_rendering;
    params.dir_n=[out_dir_rendering '_neighbours'];
    % params.dir_n=['swapAllCombos_unique_3_gt_nn_neighbours_' num2str(k_no)];
    params.in_dir_pre='/lustre/maheenr/results_temp_09_13/';
    params.in_dir_pre_html='/results_temp_09_13/';
    params.str_pre={'list_best_gt','list_best_pred'};
    params.str_post={'_overlay','_normal','_floor'};
    params.str_pre_nn={'list_best_pred'};
    params.str_post_nn={'_overlay'};
    params.html_name='results_nn.html';
    writeHTML(params,1)
end
end