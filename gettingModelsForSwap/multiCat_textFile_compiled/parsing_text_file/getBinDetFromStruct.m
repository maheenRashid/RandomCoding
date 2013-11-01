function [bin_det,bin_dets,confs]=getBinDetFromStruct(match_data,thresh)
    if nargin<2
        thresh=0.5;
    end


   box_overlap_cell={match_data(:).box_overlap_all};
    skp_cat_cell={match_data(:).skp_cat};
    cat_dpm_cell={match_data(:).cat_dpm_gt};
    bin_dets=cell(size(cat_dpm_cell));
    confs=cell(size(cat_dpm_cell));
    
    for i=1:numel(box_overlap_cell)
        box_overlap_curr=box_overlap_cell{i};
        conf_curr=zeros(size(box_overlap_curr,1),1);
        bin_det_curr=zeros(size(box_overlap_curr,1),1);
        
        [x,y]=find(box_overlap_curr>thresh);
        
        
        for x_idx=1:numel(x)
            if bin_det_curr(x(x_idx))>0
                continue
            end
            conf_curr(x(x_idx))=skp_cat_cell{i}(y(x_idx));
%             cat_dpm_cell{i}(x(x_idx))
%             skp_cat_cell{i}(y(x_idx))
%             bin_curr=cat_dpm_cell{i}(x(x_idx))==skp_cat_cell{i}(y(x_idx))
            bin_det_curr(x(x_idx))=cat_dpm_cell{i}(x(x_idx))==skp_cat_cell{i}(y(x_idx));
        end
        if numel(x)>0
            
           
        end
        
        bin_dets{i}=bin_det_curr;
        confs{i}=conf_curr;
    end
    
    bin_det=sum(cell2mat(bin_dets),2)>0;


end