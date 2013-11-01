function p_handles=display3DComp(h,comp)

if mod(numel(comp),2)==0
    size_comp=size(comp,2);
else
    size_comp=size(comp,2)-1;
end    

figure(h);
hold on;
p_handles=zeros(1,size_comp/2);
idx=1;
for facesIndex = 1:2:size_comp
    pointsTrans = comp{facesIndex};
    polygons = comp{facesIndex+1};
    p=patch('vertices', (pointsTrans), 'faces', abs(polygons'));
    set(p,'FaceColor',rand(1,3));
    p_handles(idx)=p;
    idx=idx+1;
end

end
