function [ agentPoints ] = assign_points( agentPositions, coms, sides, partitionNumber,r_o,algorithm_type,E )
% Assigns the points that can be seen by the agents to their closest
% agents. These points are added to agentPoints, a 1xn cell array, where
% the ith cell is an rx2 matrix containing the ith agent's points.

% CellPoints contains all the points that a coms group can see. Then
% cellpoints is divided between the agents in the corresponding coms group.
r = size(coms,2);

n = size(agentPositions,1);
agentPoints = cell(1,n);

for i = 1 : n
    agentPoints{1,i} = -1*ones(1,2); % Initialize agentPoints to [-1 -1] arrays.
end

for i = 1 : r % iterate over each cell
    cellPoints = [-1 -1];
    for j = 1 : size(coms{1,i},1) % iterate over each bot in each cell, which are already ordered
        agentNum = coms{1,i}(j); % find number label of first ordered agent
        x_0 = agentPositions(agentNum,1); % find position of that agent
        y_0 = agentPositions(agentNum,2);
        % Find the 'square' surrounding (x_0,y_0)
        xMin = max((ceil(partitionNumber*(x_0-r_o))/partitionNumber),1/partitionNumber);
        yMin = max((ceil(partitionNumber*(y_0-r_o))/partitionNumber),1/partitionNumber);
        xMax = min((ceil(partitionNumber*(x_0+r_o))/partitionNumber),sides);
        yMax = min((ceil(partitionNumber*(y_0+r_o))/partitionNumber),sides);
        for x = xMin : 1/partitionNumber : xMax % iterate through x values in the square
            for y = yMin : 1/partitionNumber : yMax % iterate through y values in the square
                if sqrt(double(x-x_0)^2 + double(y-y_0)^2) <= r_o % check if (x,y) is in the circle of observation
                    cellPoints = addToArray(cellPoints,x,y);
                end
            end
        end
    end
    for j = 1 : size(cellPoints,1) % iterate over each point in each cell
            x = cellPoints(j,1);
            y = cellPoints(j,2);
            minAgentNum = coms{1,i}(1); 
            x_0 = agentPositions(minAgentNum,1);
            y_0 = agentPositions(minAgentNum,2);
            minimum = distance_between(x_0,y_0,x,y,algorithm_type,E(minAgentNum));
            for k = 2 : size(coms{1,i},1) % iterate over the agents in that cell
                agentNum = coms{1,i}(k);
                x_0 = agentPositions(agentNum,1);
                y_0 = agentPositions(agentNum,2);
                if distance_between(x_0,y_0,x,y,algorithm_type,E(agentNum)) < minimum
                    minimum = distance_between(x_0,y_0,x,y,algorithm_type,E(agentNum));
                    minAgentNum = agentNum;
                end
            end
            agentPoints{1,minAgentNum} = addToArray(agentPoints{1,minAgentNum},x,y);
    end
end
end

