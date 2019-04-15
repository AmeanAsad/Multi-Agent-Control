function [ Pos ] = bump( Pos, Partition_Number, sides)
% This function is called when two agents are initially on the same point,
% which is a situation we need to prevent. 
% This function moves the agent randomly, while ensuring that the moved 
% agent stays within the arena.

% -------------------------------------------------------------------------
% If agent is on boundary of the arena, move it towards the center of the
% arena.
if Pos(1) == 1/Partition_Number
    Pos(1) = 2/Partition_Number;
elseif Pos(1) == sides;
    Pos(1) = Pos(1) - 1/Partition_Number;
elseif Pos(2) == 1/Partition_Number
    Pos(2) = 2/Partition_Number;
elseif Pos(2) == sides;
    Pos(2) = Pos(2) - 1/Partition_Number;

% -------------------------------------------------------------------------
% Agent is not on the boundary, so it will be moved in a random direction.
else
    direction = randi([1,4],1,1);
    switch direction
        case 1
            Pos(2) = Pos(2) + 1/Partition_Number;
        case 2
            Pos(1) = Pos(1) + 1/Partition_Number;
        case 3
            Pos(2) = Pos(2) - 1/Partition_Number;
        case 4
            Pos(1) = Pos(1) - 1/Partition_Number;
    end

end

