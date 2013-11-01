ccc
dir_parent='/home/maheenr/results_temp_09_13';

folder='swapModel_allBoxes_bestSortedByDPMScore_gt_withText_refine';

dir_all_boxes=fullfile(dir_parent,folder);
script_parsing;

out_dir=fullfile(dir_parent,[folder '_html']);
org_dir=pwd();
copyfile('writingHTMLs_allBoxes.m',fullfile(out_dir,'writingHTMLs.m'));
cd (out_dir);
writingHTMLs;
cd (org_dir);

