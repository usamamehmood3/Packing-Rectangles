% clc
% clear all
% close all
subplot(1,2,1);
axis([0 1 0 1]);
axis equal
hold on
n =500; %Number of Points
delay = 0.1;
lol1 = 0;
lol2 = 0;
%% Generate Points
[X, Y] = Gen_Random(n);
plot(X, Y, 'k*');
points = [X',Y'];
points = [points , points(:,1)+points(:,2) ];
points = sortrows(points, -3);
points = [points , points(:,1)+points(:,2) ];
points = sortrows(points, -3);
%% Graph Generation.
points = points(:,1:2);
points = [[1 1]; points; [0 0] ];
n = n + 2;

Top_Right = [ points(:,1), ones(n,1), ones(n,1), points(:,2) ];

A = zeros(n);
index = 1;
done = false;
AreaSum = 0;
while ~done
    index = index + 1;
    p1 = points(index, :);
    candidates = [];
    for i = 1:index-1
        p2 = points(i, :);
        if IfInside(p1, p2)
            candidates = [candidates i];
        end
    end
    for x = candidates
        row = A(x,:);
        if sum(row(candidates)) == 0
            p2 = points(x,:);
            A(x, index) = 1;
        end
    end
    if index >= n
        done = true;
    end
    
end
Aorg = A;
%subplot(3,3,1);
%GraphPlot(A, points)
%% Rectangulation Algorithm: Computing the stair
norg = n;
nodesorg = (1 : norg)';
done = false;
index = 2;
id = 2;
remas = 0;
while ~done
    tic
    nodes = (1:n)';
    Top = Top_Right(index, 1:2);
    Right = Top_Right(index, 3:4);
    [corners, inset] = Corners2( A, points, index ,Top, Right);
    p1 = points(index,:);
    %Rectangulation:
    size_corners = size(corners);
    temp = (corners - repmat(p1,[size_corners(1), 1]));
    temp = temp(:,1).*temp(:,2);
    c = find(temp==max(temp));
    c = c(1);
    sel_corner = corners(c,:);
    mes = abs(sel_corner - p1);
    AreaSum = AreaSum + mes(1)*mes(2);
    
    col = Aorg(:,index);
    inset = nodes(col>0);
    
    aa = points(1:norg,1) > points(index,1);
    bb = points(1:norg,2) > points(index,2);
    inset = nodes(aa.*bb>0);
    
    %Removal of lines.
    for x = inset'
        t1 = A(x,:);
        t2 = A(x,:) > 0;
        To_set = nodes(t2);
        if numel(To_set) == 0
            continue;
        end
        for y = To_set'
            if y == index
                continue;
            end
            pt = points(y,:);
            if pt(1)> p1(1) && pt(1) < sel_corner(1) && pt(2)<p1(2)
                A(x,y) = 0; %Break edge
            elseif pt(2) > p1(2) && pt(2) < sel_corner(2) && pt(1) < p1(1)
                A(x,y) = 0; %Break edge
            end
        end
    end
    %Add horizontal and vertical new edges.
    %Vertical - Top
    a = points(1:norg,1) < sel_corner(1);
    b = points(1:norg,1) > p1(1);
    c = points(1:norg,2) > sel_corner(2);
    d = points(1:norg,2) < p1(2);
    ver_cand_1 = nodes((a.*b.*c)>0);
    ver_cand_2 = nodes((a.*b.*d)>0);

    for z = ver_cand_2'
        vi = points(z,:);
        dTop = abs(Top_Right(z,2) - vi(2)); %Current Distance
        ndTop = abs(p1(2) - vi(2)); %New Distance
        if numel(vi) == 0
            break;
        end
        if ndTop < dTop
            Top_Right(z,1:2) = [vi(1) ,p1(2)];
        end
    end
    
    %Horizontal
    a = points(1:norg,2) < sel_corner(2);
    b = points(1:norg,2) > p1(2);
    c = points(1:norg,1) > sel_corner(1);
    d = points(1:norg,1) < p1(1);
    hor_cand_1 = nodes((a.*b.*c)>0);
    hor_cand_2 = nodes((a.*b.*d)>0);

    for z = hor_cand_2'
        vi = points(z,:);
        dRight = abs(Top_Right(z,3) - vi(1));
        ndRight = abs( p1(1) - vi(1)); 
        if numel(vi) == 0
            break;
        end
        if ndRight < dRight
        Top_Right(z,3:4) = [p1(1) ,vi(2)];
        end
    end
    %subplot(3,3,id)
    plot(p1(1), p1(2),'g*');
    %rectangle('position',[p1 sel_corner-p1], 'FaceColor', repmat(0.5+0.4*rand(),[1,3]));
    FaceClr = repmat(rand, 1, 3);
    rectangle('position',[p1 sel_corner-p1], 'FaceColor', FaceClr);
    
    if index==norg
        done = true;
    end
    index = index + 1;
    id = id+1;
    toc
    pause(delay-toc);
end

disp(['Area Coverage ratio = ',num2str(AreaSum)])

plot(X, Y, 'k*');
subplot(1,2,2);
GraphPlot(Aorg, points(1:norg,:))
axis equal













