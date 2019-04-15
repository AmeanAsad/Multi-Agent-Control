function [ Agent_Positions ] = Check_Repetition( Agent_Positions, Partition_Number, sides )
% Checks if any agents are in the same positions. If they are, agents are
% moved accordingly using the function 'bump'.
flag = 0;
n = size(Agent_Positions,1);
while flag == 0
    flag = 1;
    for i = 1 : n
        for j = i+1 : n % Cannot check itself
            if (Agent_Positions(i,1) == Agent_Positions(j,1)) && (Agent_Positions(i,2) == Agent_Positions(j,2))
                flag = 0;
                Agent_Positions(i,:) = bump(Agent_Positions(i,:),Partition_Number,sides);
            end
        end
    end
end
end