function [ corners, inset ] = Corners2( A, points, index, Top, Right )
%STAIR 
    nodes = (1:numel(points)/2)';
    p1 = points(index,:);
    col = A(:,index);
    inset = nodes(col>0); %For breaking connections.
    stair = [Top;points(inset,:);Right];
    stair = sortrows(stair,-2);
    corners = [stair(2:end,1) stair(1:end-1,2)];
end

