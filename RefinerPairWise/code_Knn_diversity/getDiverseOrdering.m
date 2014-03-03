function [idx_rec,dist_rec,ssd_rec]=getDiverseOrdering(train_data,valid_data)



[IDX,D]=knnsearch(train_data.X,valid_data.X,'K',size(train_data.X,1));


IDX_sort=zeros(size(IDX));
D_sort=zeros(size(IDX));
sort_idx=zeros(size(IDX));
for i=1:size(IDX,1)
    [IDX_sort(i,:),sort_idx(i,:)]=sort(IDX(i,:));
    D_sort(i,:)=D(i,sort_idx(i,:));
end

IDX=IDX_sort;
D=D_sort;



y_pool=zeros(0,1);

d_rest=D;
y_rest=train_data.y;

%%%
idx_rec_meta=1:numel(y_rest);
%%%

y_test=valid_data.y;
ssd_rec=zeros(size(d_rest,2),1);
idx_rec=zeros(size(d_rest,2),1);
dist_rec=zeros(size(d_rest,2),1);

d_min_yet=inf(size(D,1),0);
idx_min_yet=zeros(size(D,1),1);


for i=1:size(d_rest,2)
%     fprintf('i: %d\n',i);
    
    y_curr=[y_pool;0];
    d_curr=[d_min_yet,inf(size(D,1),1)];
    
    
    [ssd_rest,min_d_rest]=getPerformanceScore(d_rest,y_rest,d_curr,y_curr,y_test,idx_min_yet);
    
    [min_ssd,min_idx]=min(ssd_rest);
    
    dist_rec(i)=min_d_rest(min_idx);
    ssd_rec(i)=min_ssd;
%     idx_rec(i)=min_idx;

    %%%
    idx_rec(i)=idx_rec_meta(min_idx);
    %%%
    
    y_pool=[y_pool;y_rest(min_idx)];
    
    [d_min_yet,idx_temp]=min([d_min_yet,d_rest(:,min_idx)],[],2);
    if i~=1
        idx_min_yet(idx_temp==1)=idx_min_yet(idx_temp==1);
        idx_min_yet(idx_temp==2)=numel(y_pool);
    else
        idx_min_yet(:)=1;
    end
    
    d_rest(:,min_idx)=[];
    y_rest(min_idx)=[];
    
    %%%
    idx_rec_meta(min_idx)=[];
    %%%
end





end


function [ssd_rest,distance_rest]=getPerformanceScore(d_rest,y_rest,d_curr,y_curr,y_test,idx_min_yet)
    ssd_rest=zeros(size(d_rest,2),1);
    for j=1:size(d_rest,2)
        d_curr(:,end)=d_rest(:,j);
        y_curr(end)=y_rest(j);
        
        [min_d,idx_curr]=min(d_curr,[],2);

        if size(d_curr,2)~=1
            idx_actual(idx_curr==1)=idx_min_yet(idx_curr==1);
            idx_actual(idx_curr==2)=numel(y_curr);
        else
            idx_actual=idx_curr;
        end
        
        y_pred=y_curr(idx_actual);
        ssd_rest(j)=sum((y_pred-y_test).^2);
        distance_rest(j)=sum(min_d);
    end
end