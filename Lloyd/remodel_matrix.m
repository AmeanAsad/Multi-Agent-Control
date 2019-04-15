function [spread_matrix] = remodel_matrix(spread_matrix, new_fire_cells)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    size_temp = size(new_fire_cells);
    
    size_of_fire_cells = size_temp(1);
    
    for i=1:size_of_fire_cells
        x = new_fire_cells(i,1);
        y = new_fire_cells(i,2);
        spread_matrix(x,y) =  0.5;
   
    end
end

