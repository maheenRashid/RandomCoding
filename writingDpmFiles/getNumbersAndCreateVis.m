% ccc
% dir_in_pre='gt_models';
% dir_in_post='Img_GT_Features';
% svm_type='svm_structs_etc_violate.mat';
% % svm_type='svm_structs_etc.mat';
% svm_type='svm_structs_etc_justBBAndConfAndType.mat';
% 
% load(svm_type,'pred_vs_real','gt_list','dpm_svm_data','errorLog');
% 
% bin=cellfun(@isempty,pred_vs_real);
% pred_vs_real_temp=pred_vs_real;
% pred_vs_real_temp(bin)=[];
% accuracy=getAccuracy(pred_vs_real_temp,1)
% 
% dir_curr=svm_type(1:end-4);
% if ~exist(dir_curr,'dir')
%     mkdir(dir_curr);
% end
% 
% for gt_no=1:numel(gt_list)
%     name_curr=gt_list{gt_no};
%     if numel(find(strcmp(name_curr,errorLog)))>0
%         continue;
%     end
%     
%     if isempty(pred_vs_real{gt_no})
%         continue;
%     end
%     
%     gt_box=pred_vs_real{gt_no}(:,1);
%     pred_box=pred_vs_real{gt_no}(:,2);
%     
%     
%      h=figure;
%      imshow(imread(fullfile(dir_in_pre,name_curr,dir_in_post,'object_mask_overlay.png')));
%      h1=figure;
%      
%      imshow(imread(fullfile(dir_in_pre,name_curr,dir_in_post,'object_mask_overlay.png')));
%      
%      feature_curr=dpm_svm_data{1,gt_no};            
%      
%      str_boxes={'-k','-r'};
%      
%      for box_no=1:size(feature_curr,1)
%         plotBoxes(h,feature_curr(box_no,1:4),str_boxes{gt_box(box_no)+1});
%         
%         plotBoxes(h1,feature_curr(box_no,1:4),str_boxes{pred_box(box_no)+1});
%      end
%      
%      saveas(h,fullfile(dir_curr,[name_curr '_gt.png']));
%      
%      saveas(h1,fullfile(dir_curr,[name_curr '_pred.png']));
%      
%      close(h);
%      close(h1);
%      
%      
% end



fid_html=fopen(fullfile(dir_curr,'results.html'),'w');
fprintf(fid_html,'%s\n','<html>');
for gt_no=1:numel(gt_list)
    id=gt_list{gt_no};
    id=strrep(id,'#','%23');
    fprintf(fid_html,'%s\n',[num2str(accuracy(1)) '<br>']);
    fprintf(fid_html,'%s\n',[num2str(accuracy(2)) '<br>']);
    fprintf(fid_html,'%s\n',['<img width="25%" src="' fullfile([id '_gt.png']) '">']);
    fprintf(fid_html,'%s\n',['<img width="25%" src="' fullfile([id '_pred.png']) '">']);
    fprintf(fid_html,'%s\n','<br>');
end
fprintf(fid_html,'%s\n','<html>');
fclose(fid_html);
