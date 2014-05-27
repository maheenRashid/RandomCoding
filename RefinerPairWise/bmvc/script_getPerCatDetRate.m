ccc


dir_parent_meta='/lustre/maheenr/cube_per_cam_regenerate';

% dir_in=fullfile(dir_parent_meta,'room3D_auto');
% dir_proc='processing_lists_noprune_noNeg';

dir_in=fullfile(dir_parent_meta,'room3D_gt');
dir_proc='processing_lists_noprune_noNeg_all';

best_lists=dir(fullfile(dir_in,dir_proc,'best_list_varying_by_prec_withCat_noOrder*'));
best_lists={best_lists(:).name};


cat_types=[1,2,4,8,9];

for list_no=5
    %     numel(best_lists)
    dir_rendering=best_lists{list_no};
    for cat_no=cat_types
        
        out_mutex=fullfile(dir_in,[dir_rendering '_html'],['det_overlap_mutex_' num2str(cat_no)]);
%         if ~exist(out_mutex,'dir')
%             mkdir(out_mutex);
%         else
%             continue;
%         end
        
        
        dir_masks=fullfile(dir_in,[dir_rendering '_html'],'record_masks');
        
        models=dir(fullfile(dir_masks,'*sun*.mat'));
        models={models(:).name};
        
        det_record=struct('id',models,'det_overlap',cell(size(models)));
        matlabpool open;
        parfor model_no=1:numel(models)
            fprintf('%d\n',model_no);
            
            masks=load(fullfile(dir_masks,models{model_no}));
            record_masks=masks.record_masks;
            if ~isfield(record_masks,'os_pix')
                continue;
            end
            
            idx_gt=find(record_masks.cats_gt==cat_no);
            idx_pred=find(record_masks.cats~=cat_no);
            os_pix=record_masks.os_pix;
            os_pix(:,idx_pred)=0;
            overlap=os_pix(idx_gt,:);
            overlap_max=max(overlap,[],2);
            det_record(model_no).det_overlap=overlap_max;
            
        end
        matlabpool close;
        
        idx_emp={det_record(:).det_overlap};
        idx_emp=cellfun(@isempty,idx_emp);
        det_record(idx_emp)=[];
        save(fullfile(dir_masks,['record_cat_' num2str(cat_no) '.mat']),'det_record');
    end
end