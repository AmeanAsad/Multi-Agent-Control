function [boundary] = matrix_edge_detection(matrix,size)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    size = size-1;
    boundary = [];
    for x = 2:size- 1
        for y = 2:size-1
            if matrix(x,y) >0
                if cell_edge_detection([x,y], matrix)
                    boundary = [boundary;[x,y]];
                end
            end
        end
    end

end

