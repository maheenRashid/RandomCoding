ccc

data_size=[10,100,1000,10000,100000,1000000,1000000];
no_col=160;

no_par=zeros(size(data_size));
par=zeros(size(data_size));

for d_s_no=1:numel(data_size)
    data=rand(data_size(d_s_no),no_col);
    tic();
    for i=1:size(data,1)
        norm_curr=norm(data(i,:));
        data(i,:)=bsxfun(@rdivide,data(i,:),norm_curr);
    end
    no_par(d_s_no)=toc()
    
    
    data=rand(data_size(d_s_no),no_col);
    tic();
    matlabpool open
    parfor i=1:size(data,1)
        norm_curr=norm(data(i,:));
        data(i,:)=bsxfun(@rdivide,data(i,:),norm_curr);
    end
    matlabpool close;
    par(d_s_no)=toc()

end

