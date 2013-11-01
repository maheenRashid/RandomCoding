ccc

x_range=[-2.5,1];
y_range=[-1,1];
% x_range=[-1.2,-1.1];
% y_range=[0.25,0.5];

x_im_max=1000;
y_im_max=floor(x_im_max/diff(x_range)*diff(y_range));
im=zeros(y_im_max,x_im_max);
% figure; hold on;
for x_im=1:x_im_max
    for y_im=1:y_im_max
        x=(x_im/x_im_max*diff(x_range))+min(x_range);
        y=(y_im/y_im_max*diff(y_range))+min(y_range);
        
        c=x+1i*y;
        z=0;
        max_iter=1000;
        for count=1:max_iter
            if abs(z)>2
                break;
            end
            
            z=z^2+c;
            
        end
        
%         plot(x,y,'.','color',[count/max_iter,1,0]);
        
        im(y_im,x_im)=count;
        
        
        
        
    end
end

figure;
imagesc(im);
% xlim(x_range);ylim(y_range);