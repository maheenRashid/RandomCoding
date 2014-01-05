ccc

parent_dir='models_swap';
models=dir(parent_dir);
models={models(3:end).name};

orig='each_rep_-01_-01_-01_-01_-01_overlay.png'


string_to_render={'final','final_rep_*'};

for model_no=1:numel(models)

    path=fullfile(parent_dir,models{model_no});
    
    orig_curr=imread(fullfile(path,orig));
    
    for render_no=1:numel(string_to_render)
        im_overlay=dir(fullfile(path,[string_to_render{render_no} '_overlay.png']));
        im_overlay=imread(fullfile(path,im_overlay(1).name));
        
        im_normal=dir(fullfile(path,[string_to_render{render_no} '_normal.png']));
        im_normal=imread(fullfile(path,im_normal(1).name));
        
        im_mix=getNormalOverlay(im_overlay,im_normal,orig_curr);
        
        out_file_name=dir(fullfile(path,[string_to_render{render_no} '_normal.png']));
        out_file_name=out_file_name(1).name;
        out_file_name=[out_file_name(1:end-11) '_mix.png'];
        imwrite(im_mix,fullfile(path,out_file_name));
        
        
%         pause;
        
    end
    
    


end