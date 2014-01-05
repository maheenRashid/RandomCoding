function [dpm_boxes,dpm_cat_no,dpm_bin,dpm_objmap,dpms_str]=getDPMInfoSorted(dpms,mapping,str_labels)

    dpms_str=cell(1,0);
    for dpm_no=1:size(dpms,2)
        box_curr=dpms{3,dpm_no};
        cell_curr=cell(1,size(box_curr,1));
        [cell_curr{1,:}]=deal(dpms{1,dpm_no});
        dpms_str=[dpms_str cell_curr];
    end
    dpms_str=dpms_str';
    dpm_boxes=cell2mat(dpms(3,:)');
    dpm_bin=cell2mat(dpms(4,:)');
    dpm_objmap=cell2mat(dpms(5,:)');
    
    dpm_cat_no=cellfun(@(x) mapping(strcmp(x,str_labels)),dpms_str);
    [~,idx_sort]=sort(dpm_boxes(:,end),'descend');
    dpm_cat_no=dpm_cat_no(idx_sort);
    dpm_boxes=dpm_boxes(idx_sort,:);
    dpm_bin=dpm_bin(idx_sort);
    dpm_objmap=dpm_objmap(idx_sort);
    dpms_str=dpms_str(idx_sort);
end