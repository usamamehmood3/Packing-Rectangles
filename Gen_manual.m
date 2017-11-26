function [X, Y ] = Gen_manual( n )
%GEN_MANUAL Summary of this function goes here
%   Detailed explanation goes here
done = false;
X = zeros(1,n);
Y = zeros(1,n);
i = 1;
while ~done
    P = ginput(1);
    X(i) = P(1);
    Y(i) = P(2);
    plot(P(1),P(2),'k*');
    if i >= n
        done = true;
    end
    i = i + 1;
end

end

