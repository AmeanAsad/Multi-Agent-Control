function [ Points ] = addToArray( Points, x, y )
% Adds (x,y) to the array Points. If (x,y) is already in Points, then 
% nothing happens. Points remains sorted first by x, then by y throughout
last = size(Points, 1);
% If Points is empty, add (x,y)
if Points(1,1) == -1 && Points(1,2) == -1 
    Points(1,:) = [x,y];
% If (x,y) should be placed at the end, add it to the end immediately.
elseif Points(last,1) < x || (Points(last,1) == x && Points(last,2) < y)
    Points = vertcat(Points,[x,y]);
% Otherwise, call arraySearch.
else
    [index, found] = arraySearch(Points, x, y);
    if found == 0 % If (x,y) is not there, then add it while maintaining order.
        for i = last : -1 : index
            Points(i+1,:) = Points(i,:);
        end
        Points(index,:) = [x,y];
    end
    % If (x,y) is there, then do nothing.
end
end

