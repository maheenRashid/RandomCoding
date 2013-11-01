function score=getDetScore(accu_cell,ratio)

    zero_det=accu_cell(accu_cell(:,2)==0,1);
    one_det=accu_cell(accu_cell(:,2)==1,1);
    
    zero_r=sum(zero_det)/numel(zero_det);
    one_r=sum(one_det)/numel(one_det);
    
    zero_w=ratio(1)/sum(ratio);
    one_w=ratio(2)/sum(ratio);
    
    score=zero_w*zero_r+one_w*one_r;
% 
% 
%     zero_det=accu_cell(accu_cell(:,2)==0,1);
%     zero_det=ratio(1)*zero_det;
%     one_det=accu_cell(accu_cell(:,2)==1,1);
%     one_det=ratio(2)*one_det;
%     score=sum(zero_det)+sum(one_det);
%     score=score/size(accu_cell,1);
end