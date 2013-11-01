ccc

threshes=1:10;

threshes_str=cellfun(@(x) num2str(x),num2cell(threshes),'UniformOutput',0);
bin_mat=zeros(numel(threshes),3);

load(fullfile('..','accuracy_cell_cmp_kept.mat'))

for thresh_no=1:numel(threshes)
    thresh=threshes(thresh_no);
    load(fullfile('..','swapModel_allBoxes_bestSortedByDPMScore_gt_withText_refine_html'...
        ,['record_overlaps_and_binDet_' num2str(thresh) '.mat']),'record_overlaps');

    
%     return    
%     record_overlaps(model_no).bin_det=bin_det;
%     record_overlaps(model_no).bin_dpm=match_data(1).bin_dpm_gt;
%     record_overlaps(model_no).obj_map_gt=match_data(1).obj_map_gt;
%         
    ids={record_overlaps(:).id};
    
    names_for_quick_match=cellfun(@(x) x{end},cellfun(@(x) regexpi(x,'#','split'),ids,'UniformOutput',0),'UniformOutput',0);
    
    bin_det_cell={record_overlaps(:).bin_det};
    obj_map_gt_cell={record_overlaps(:).obj_map_gt};
    bin_dpm_cell={record_overlaps(:).bin_dpm};
    
    for i=1:numel(bin_det_cell)
        
        bin_kept=accuracy_cell{1,strcmp(names_for_quick_match{i},accuracy_cell(2,:))}(:,end);
        
        bin_det_old=bin_det_cell{i};
        bin_det_old=bin_det_old>0;
        bin_kept=bin_kept>0;
        
        bin_det_new=bin_det_old | bin_kept;
        
%         bin_det_new=bin_kept;
        
        
%         if ~isequal(bin_det_new,bin_det_old)
%             keyboard;
%         end
        
        [bin_match,bin_dpm_new]=getBinMatchWithObjMap(bin_dpm_cell{i},obj_map_gt_cell{i},bin_det_new);    
        bin_dpm_cell{i}=bin_dpm_new;
        bin_det_cell{i}=bin_det_new;
        
        
        
        
    end
    bin_det_all=cell2mat(bin_det_cell');
    bin_dpm_all=cell2mat(bin_dpm_cell');
    
%     bin_det_all=cell2mat({record_overlaps(:).bin_det}');
%     bin_dpm_all=cell2mat({record_overlaps(:).bin_dpm}');
    
    accu=sum(bin_det_all==bin_dpm_all)/numel(bin_dpm_all);
    zero_accu=sum(bin_det_all==bin_dpm_all & bin_dpm_all==0)/sum(bin_dpm_all==0);
    one_accu=sum(bin_det_all==bin_dpm_all & bin_dpm_all==1)/sum(bin_dpm_all==1);
    
    bin_mat(thresh_no,1)=accu;
    bin_mat(thresh_no,2)=zero_accu;
    bin_mat(thresh_no,3)=one_accu;
end

figure;
bar(bin_mat);
set(gca,'XTickLabel',threshes_str);
grid on;




return
ccc
load (fullfile('..','swapModel_allBoxes_bestSortedByDPMScore_gt_withText_refine_html'...
    ,'record_overlaps_and_record_dpm.mat'),'record_overlaps','record_dpm');


check=cellfun(@(x) isfield(x,'box_overlap_all'),{record_overlaps(:).match_data});


record_overlaps_org=record_overlaps(check);


for thresh=0.1:0.1:1
    
    record_overlaps=record_overlaps_org;
    
    for model_no=1:numel(record_overlaps)
        match_data=record_overlaps(model_no).match_data;
        
        [bin_det,bin_dets,confs]=getBinDetFromStruct(match_data,thresh);

        record_overlaps(model_no).bin_det=bin_det;
        record_overlaps(model_no).bin_dpm=match_data(1).bin_dpm_gt;
        record_overlaps(model_no).obj_map_gt=match_data(1).obj_map_gt;
        record_overlaps(model_no).bin_dets=bin_dets;
        record_overlaps(model_no).confs=confs;
    end
    
    save(fullfile('..','swapModel_allBoxes_bestSortedByDPMScore_gt_withText_refine_html'...
    ,['record_overlaps_and_binDet_' num2str(thresh*10) '.mat']),'record_overlaps');
    
end
