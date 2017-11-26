clc
clear all
trials = 50;
values = 50;
Results = zeros(1,values);

for n = 1:values
    disp(num2str(n));
    Area = 0;
    for t = 1:trials
        Area = Area + Algo1_fn(n);
    end
    Results(n) = Area/trials;
end
plot(1:values,Results,'-*');
