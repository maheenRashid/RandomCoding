ccc


dir_parent_meta='/lustre/maheenr/cube_per_cam_regenerate';

dir_in=fullfile(dir_parent_meta,'room3D_auto');
dir_proc='processing_lists_noprune_noNeg';

% dir_in=fullfile(dir_parent_meta,'room3D_gt');
% dir_proc='processing_lists_noprune_noNeg_all';

best_lists=dir(fullfile(dir_in,dir_proc,'best_list_varying_by_prec_withCat_noOrder*'));
best_lists={best_lists(:).name};
best_lists=[best_lists 'nn_render'];

dir_gt=fullfile(dir_parent_meta,'room3D_auto','gt_record');
load(fullfile(dir_gt,'record_gt_sun_with_orients.mat'),'record_gt');

ids_gt={record_gt(:).id};

cat_types=[1,2,4,8,9];

for list_no=numel(best_lists)
    dir_rendering=best_lists{list_no};
    for cat_no=1
%         cat_types
        
        out_mutex=fullfile(dir_in,[dir_rendering '_html'],['det_overlap_box_mutex_' num2str(cat_no)]);
        %         if ~exist(out_mutex,'dir')
        %             mkdir(out_mutex);
        %         else
        %             continue;
        %         end
        
        dir_masks=fullfile(dir_in,[dir_rendering '_html'],'record_masks');
        
        models=dir(fullfile(dir_masks,'*sun*.mat'));
        models={models(:).name};
        
        det_record=struct('id',models,'det_overlap',cell(size(models)));
%         matlabpool open;
%         par
        for model_no=1:numel(models)
            fprintf('%d of %d\n',model_no,numel(models));
            
            masks=load(fullfile(dir_masks,models{model_no}));
            record_masks=masks.record_masks;
            
            id=record_masks.id;
            if ~isfield(record_masks,'os_box')
                continue;
            end
            
            idx=strcmp(id,ids_gt);
            gt_curr=record_gt(idx);
            gt_orients=gt_curr.orients;
            
            idx_gt=find(record_masks.cats_gt==cat_no);
            
            idx_pred=find(record_masks.cats~=cat_no);
            os_box=record_masks.os_box;
            os_box(:,idx_pred)=0;
            overlap=os_box(idx_gt,:);
            [overlap_max,overlap_max_idx]=max(overlap,[],2);
            det_record(model_no).det_overlap=overlap_max;
            
            gt_orient_rel=gt_orients(idx_gt);
            pred_orient_rel=zeros(size(overlap_max));
            for gt_no=1:numel(overlap_max)
                if overlap_max(gt_no)>0
                    pred_orient_rel(gt_no)=record_masks.orients(overlap_max_idx(gt_no));
                end
            end
            
            det_record(model_no).orient_gt=gt_orient_rel;
            det_record(model_no).orient_pred=pred_orient_rel;
            det_record(model_no).quad=gt_curr.quad;
            det_record(model_no).transnum=record_masks.transnum;
        end
%         matlabpool close;
        
        idx_emp={det_record(:).det_overlap};
        idx_emp=cellfun(@isempty,idx_emp);
        det_record(idx_emp)=[];
        save(fullfile(dir_masks,['record_cat_box_' num2str(cat_no) '.mat']),'det_record');
    end
end