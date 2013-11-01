function displayObjects(database,im_str)
im=imread(im_str);
noPolygon=numel(database.annotation.object) ;
[nrows,ncols]=size(im);
 h=figure;
    imshow(im); hold on
for j=1:noPolygon
%     [X,Y] = getLMpolygon(database.annotation.object(j).polygon);
    X=database.annotation.object(j).polygon.x;
    Y=database.annotation.object(j).polygon.y;
    
%     crop(1) = max(min(X)-2,1);
%                 crop(2) = min(max(X)+2,ncols);
%                 crop(3) = max(min(Y)-2,1);
%                 crop(4) = min(max(Y)+2,nrows);
%                 crop = round(crop);
%                 X=X-crop(1)+1;
%                 Y=Y-crop(3)+1;
%                 h = plot([X; X(1)]-crop(1)+1, [Y; Y(1)]-crop(3)+1, 'r', 'linewidth', 2);
%     
   
    plot([X; X(1)], [Y; Y(1)], 'r', 'linewidth', 2);
    
end
end