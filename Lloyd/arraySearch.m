function [ index, found ] = arraySearch( Points, x, y )
% If Points contains (x,y), then found = 1 and index is the index of Points
% that contains (x,y). If Points does not contain (x,y), then found = 0 and
% index is the index at which (x,y) should be inserted.

low = 1;
high = size(Points,1);
x_found = 0;
found = 0;
while low <= high
    mid = floor((low + high)/2);
    if Points(mid,1) < x
        low = mid + 1;
    elseif Points(mid,1) > x
        high = mid - 1;
    else
        x_found = 1;
        break
    end
end

if x_found == 0
    if high == size(Points,1)
        index = size(Points,1)+1;
    elseif low == 1
        index = 1;
    else
        while Points(low-1,1) > x
            low = low - 1;
        end
        index = low;
    end
elseif x_found == 1
    start = mid;
    finish = mid;
    while start > 1
        if Points(start-1,1) == x
            start = start-1;
        else
            break
        end
    end
    while finish < size(Points,1)
        if Points(finish+1,1) == x
            finish = finish + 1;
        else
            break
        end
    end
    
    [y_index, y_found] = vectorSearch(Points(start:finish,2:2),y);
    
    found = y_found;
    index = start + y_index - 1;
    
    
    
end

end