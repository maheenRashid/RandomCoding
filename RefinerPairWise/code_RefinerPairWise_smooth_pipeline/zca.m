function [Y W] = zca(X, epsilon,split_no)
% ZCA: zero-phase whitening transform
%
% This function computes the linear transformation which results in an
% identify sample covariance matrix, while minimizing distortion.  An
% optional argument can be provided that specifies the regularization
% parameter, i.e., the weight given to the identity when computing the
% covariance matrix.  The function returns the transformed data, as
% well as the weight matrix used to compute it.  It is assumed that
% the data have a sample mean of zero.
%
% [Y W] = zca(X, epsilon)
%
% X:       Data matrix, size N x D
% epsilon: regularization parameter, optional, defaults to 1e-6
% Y:       Output matrix, size N x D
% W:       Transformation matrix, size D x D
%
% The primary reference for ZCA is:
% A.J. Bell and T.J. Sejnowski. The "independent components" of
% natural scenes are edge filters.  Vision Research. 37(23):3327-38,
% 1997.
%
% This implementation basically follows the treatment given in:
% http://www.cs.toronto.edu/~kriz/learning-features-2009-TR.pdf
%
% Author: Ryan P. Adams
% Copyright 2012, President and Fellows of Harvard College.

if nargin == 1
    epsilon = 1e-6;
end

if nargin<3
    split_no=10000;
end

[N D] = size(X);

% Compute the regularized scatter matrix.

scatter = (X'*X + sparse(epsilon*eye(D)));

% The epsilon corresponds to virtual data.
N = N + epsilon;

% Take the eigendecomposition of the scatter matrix.
[V D] = eigs(scatter);

% This is pretty hacky, but we don't want to divide by tiny
% eigenvalues, so make sure they're all of reasonable size.
D = max(diag(D), epsilon);

% Now use the eigenvalues to find the root-inverse of the
% scatter matrix.
irD = diag(1./sqrt(D));

% Reassemble into the transformation matrix.
W = sparse(sqrt(N-1) * V * irD * V');

% Apply to the data.
l=size(X,1);
split_no=min(split_no,l);
iter=floor(l/split_no);


idx=zeros(2,iter);
idx=[1:iter;zeros(1,iter)];
idx(1,:)=split_no*(idx(1,:)-1)+1;
idx(2,:)=idx(1,:)+split_no-1;
idx=[idx,[idx(end)+1;l]];

iter=size(idx,2);

Y=cell(iter,1);
X_cell=Y;

% iter

X_cell=struct('x',X_cell);
for i=1:iter
    
    %     tic()
    X_cell(i).x=X(idx(1,i):idx(2,i),:);
    X(idx(1,i):idx(2,i),:)=0*X(idx(1,i):idx(2,i),:);
    %     toc();
    
end
% if iter>100
%     % parpool(4);
%     matlabpool open;
%     parfor i=1:iter
%         %     fprintf('%d\n',i);
%         X_cell(i).x=full(X_cell(i).x*W);
%     end
%     matlabpool close;
%     Y={X_cell(:).x}';
% else
    for i=1:iter
        X_cell(i).x=full(X_cell(i).x*W);
    end
    Y={X_cell(:).x}';
% end

end