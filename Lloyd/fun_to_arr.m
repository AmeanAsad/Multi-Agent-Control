function [Density] = fun_to_arr(Density_function,sides,Partition_Number)

% Discretizes density function into array, called Density.

syms x y
Density = zeros(sides*Partition_Number,sides*Partition_Number);
[yy xx] = meshgrid(linspace(0,sides,sides*Partition_Number));
for i = 1:sides*Partition_Number
    for j = 1:sides*Partition_Number
        x = xx(i,j);
        y = yy(i,j);
        Density(i,j) = subs(Density_function);
    end
end
end