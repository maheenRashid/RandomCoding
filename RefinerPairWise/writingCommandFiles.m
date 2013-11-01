ccc

mat_dir='D:\ResearchCMU\git\Image-Modeling\MATLAB_for_visu';
files={'swapObjectsInBox_allOffsets_sizeComparison_bugFixed_gt.mat',...
    'swapObjectsInBox_allOffsets_sizeComparison_bugFixed.mat'};     

post_fix={'gt','auto'};
for i=1:numel(files)
 load(fullfile(mat_dir,files{i}));
 
 file_name_simple=files{i}(1:end-4);
 out_name=['swapAllCombos_unique_10_' post_fix{i}];
 path_to_text=['/lustre/maheenr/results_temp_09_13/' file_name_simple '_refPW/text_files/'];
 
 cellCommands_rep=cellfun(@(x) strrep(x,'swapObjectsInBox_check','swapPairWiseBeds'),cellCommands,'UniformOutput',0);
 cellCommands_rep=cellfun(@(x) strrep(x,file_name_simple,out_name),cellCommands_rep,'UniformOutput',0);
 ids=cellfun(@(x) strrep(x{2},'/','#'),cellfun(@(x) regexpi(x,' ','split'),cellCommands,'UniformOutput',0),'UniformOutput',0);
 cellCommands_rep=cellfun(@(x,y) [x ' ' path_to_text y '.txt'],cellCommands_rep,ids,'UniformOutput',0);
 cellCommands=cellCommands_rep;
 save(fullfile(mat_dir,[out_name '.mat']),'cellCommands');
end
