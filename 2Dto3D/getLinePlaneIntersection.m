function pt_int=getLinePlaneIntersection(plane_pts,line_pts)
diff_line_pts=line_pts(:,end)-line_pts(:,1);
numo=[ones(1,4);[plane_pts,line_pts(:,1)]];
deno=[ones(1,3) 0;[plane_pts,diff_line_pts]];
t=-det(numo)/det(deno);
pt_int=line_pts(:,1)+diff_line_pts*t
end