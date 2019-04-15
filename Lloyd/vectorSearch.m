function [ index, found ] = vectorSearch( V , y )
% If V contains y, then found = 1 and index is the index of y. Otherwise,
% found = 0 and index is the index at which y should be.
low = 1;
high = size(V,1);
while low <= high
    mid = floor((low + high)/2);
    if V(mid) < y
        low = mid + 1;
    elseif V(mid) > y
        high = mid - 1;
    else % y has been found
        index = mid;
        found = 1;
        return
    end
end

found = 0;
if high == size(V,2)
    index = size(V,2)+1;
elseif low == 1
    index = 1;
else
    while V(low-1) > y
        low = low - 1;
    end
    index = low;
end

end