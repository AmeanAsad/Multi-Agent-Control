function [edge] = cell_edge_detection(cell,m)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    x = cell(1);
    y = cell(2);
 
    matrix_boundaries = [
    m(x,y+1);
    m(x+1,y+1);
    m(x+1,y);
    m(x+1,y-1);
    m(x,y-1);
    m(x-1,y-1);
    m(x-1,y);
    m(x-1,y+1)];
    
    if any(matrix_boundaries ==0)
        edge = true;
    else
        edge = false; 
    end
end

