function [rot_dif]=getRotDiff_NN_manual(det_curr,thresh,...
    in_dir_pre,post_normal,post_overlay)

 overlap=det_curr.det_overlap;
pred_rots=det_curr.orient_pred;
gt_rots=det_curr.orient_gt;

id=det_curr.id;
id_rep=strrep(id(1:end-4),'#','%23');

bin_det=overlap>=thresh;
pred_rots=pred_rots(bin_det);
gt_rots=gt_rots(bin_det);


rot_dif=inf(size(gt_rots));
if numel(rot_dif)~=0
    im_path=fullfile(in_dir_pre,id_rep,post_normal);
    im_path=strrep(im_path,'\','/');
    im_n=imread(im_path);
    im_path=fullfile(in_dir_pre,id_rep,post_overlay);
    im_path=strrep(im_path,'\','/');
    im_o=imread(im_path);
    h=figure; subplot(1,2,1); imshow(im_o);subplot(1,2,2);imshow(im_n);
end

for pred_no=1:numel(pred_rots)
    gt_rot=gt_rots(pred_no);
    pred_rot=pred_rots(pred_no);
    if gt_rot==0
        continue;
    end
    fprintf('numel rot_dif %d\n',numel(rot_dif));
    
    
        rot_dif(pred_no)=input('enter rot:');
end
if any(strcmp(who,'h'))
close(h);
end
end