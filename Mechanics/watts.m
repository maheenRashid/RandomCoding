ccc
l1=5;
l2=3;
l3=5;



A=[0,3];
D_org=[10,0];
figure;
 figure;
for v1=0.5:0.1:1
    v=[v1,-sqrt(1-v1^2)]
    B=A+l1*v
%     keyboard;
    for v2=0.5:0.5:1
        v=[v2,-sqrt(1-v2^2)]
        C=B+l2*v
        for v3=-1:0.1:1
            v=[v3,sqrt(1-v3^2)]
%             v=v/norm(v);
            D=C+l3*v
            
            
%             if norm(D-D_org)<1
               
                hold on
                plot([A(1),B(1)],[A(2),B(2)],'-r');
                
                plot([D(1),C(1)],[D(2),C(2)],'-b');
                 
                
                plot([B(1),C(1)],[B(2),C(2)],'-g');
                hold off
                pause(0.5)
%             end
        end
    end
    
end
