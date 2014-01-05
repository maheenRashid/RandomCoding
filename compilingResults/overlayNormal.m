ccc

folder='swapObjectsInBox_allOffsets_sizeComparison_bestSortedByDPMScore_auto';
models=dir(folder);

isub = [models(:).isdir];
models=models(isub);
models={models(:).name};
models(strcmp('.',models))=[];
models(strcmp('..',models))=[];

for model_no=1:numel(models)
    
    path=fullfile(folder,models{model_no});
    
    orig=fullfile(path,'each_rep_-01_-01_-01_-01_-01_overlay.png');
    final=dir(fullfile(path,'repFinal*normal.png'));
    
    if numel(final)>1
%         keyboard;
        check_ag=fullfile(path,'final_with_cube_normal.png');
        check_ag=imread(check_ag);
        diffs=zeros(1,numel(final));
        for i=1:numel(final)
            temp=final(i).name;
            temp=imread(fullfile(path,temp));
            diff=temp~=check_ag;
            diff=diff(:);
            diff=sum(diff);
            diffs(i)=diff;
        end
        [~,idx_min]=min(diffs);
        final=final(idx_min);
    
    end
    final=fullfile(path,final(1).name);
    final_overlay=strrep(final,'normal','overlay');
    orig=imread(orig);
    final=imread(final);
    
    
    final_overlay=imread(final_overlay);
    
    
    final_mask=uint8(zeros(size(orig)));
    for i=1:size(orig,3)
        final_mask(:,:,i)=final_overlay(:,:,i)-orig(:,:,i);
    end
    final_mask=rgb2gray(final_mask);
    final_mask=final_mask>0;
    final_mask=uint8(final_mask);
    
    
    
    im_new=uint8(zeros(size(orig)));
    for i=1:size(orig,3)
    layer=final(:,:,i)*0.5+orig(:,:,i);
    im_new(:,:,i)=layer;
    end
    imwrite(im_new,fullfile(path,'repFinal_all.png'));

    
    final=final.*repmat(final_mask,[1,1,3]);
    im_new=uint8(zeros(size(orig)));
    for i=1:size(orig,3)
    layer=final(:,:,i)*0.5+orig(:,:,i);
    im_new(:,:,i)=layer;
    end
    imwrite(im_new,fullfile(path,'repFinal_justObj.png'));

    
    
    
end