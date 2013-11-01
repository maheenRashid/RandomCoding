function [ dec_curr_correct ] = orderDecisionColumns( dec_curr,pred_box )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    check=pred_box<1;
    dec_check=dec_curr(check,:);
    if numel(dec_check)==0
        temp=find(dec_curr(:,1)~=dec_curr(:,2));
        temp=temp(1);
        if dec_curr(temp,1)>dec_curr(temp,2)
            col=[1,2];
        else
            col=[2,1];
        end
    else
        temp=find(dec_check(:,1)~=dec_check(:,2));
        temp=temp(1);
        if dec_check(temp,1)>dec_check(temp,2)
            col=[2,1];
        else
            col=[1,2];
        end
    end
    
    dec_curr_correct=dec_curr(:,col);
    
    
end
