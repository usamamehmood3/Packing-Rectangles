function [] = GraphPlot( A, points )
%GRAPHPLOT Plots a graph using adjacency matric A and points.
hold on 
s = size(A);
s = s(1);
for x = 1:s
    p1 = points(x,:); %from
%     text(p1(1),p1(2),int2str(x))
    plot(p1(1),p1(2),'k*')    
    for y = 1:s
        p2 = points(y,:); %To
        if A(x,y) == 1
            line([p1(1),p2(1) ],[p1(2),p2(2) ], 'Color', [0.6 0.6 0.6], 'LineWidth', 1.2);
        end
    end
end

