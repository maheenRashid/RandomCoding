ccc

in_dir='questions_gap';
files=dir(fullfile(in_dir,'*.mat'));
n=10;

for i=1:numel(files)
    x=load(fullfile(in_dir,files(i).name));
    gap_record=x.gap_record;
    
    ndiv=[gap_record(:).ndiv];
    div=[gap_record(:).div];
    
    diff=ndiv-div;
    [~,sort_idx]=sort(diff);
    models_rel_ndiv={gap_record(sort_idx(end-n+1:end)).name};
    models_rel_div={gap_record(sort_idx(1:n)).name};
    
    x.models_rel_div=models_rel_div;
    x.models_rel_ndiv=models_rel_ndiv;
    
    
    save(fullfile(in_dir,files(i).name),'-struct','x');
    
end