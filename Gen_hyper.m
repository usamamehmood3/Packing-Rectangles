function [ X, Y ] = Gen_hyper( n )
%GEN_HYPER: Points chosen randomly on a hyperbola
scale = 2.5;
done = false;
count = 0;
X = [];
Y = [];
while ~done
   xx =  scale*rand();
   yy = 1 / xx;
   xx = xx/scale;
   yy = yy/scale;
   if yy <= 1 && yy >= 0
       count = count + 1; 
       yy
       X = [X xx];
       Y = [Y yy];
   end
   if count >= n
       done = true;
   end
   
   
end
