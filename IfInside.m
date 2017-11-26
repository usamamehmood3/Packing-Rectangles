function [ flag ] = IfInside(p1 , p2 )
%IFINSIDE p2 is inside p1
flag = p2(1) >= p1(1) && p2(2) >= p1(2);
end
