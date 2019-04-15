function [communication,com_mat] = communication_fun(Agent_Positions,r_c,Number_of_Agents,algorithm_type)
% com_mat: n x n Communication Matrix, where n is the Number of Agents.
% com_mat(i,j) = 1 if there is communication between agents i and j. 
% In the regular algorithm, communication goes both ways (i.e.
% com_mat(i,j) = com_mat(j,i) = 1). You may want to change the way in which
% communiation is established (eg. only agents close to some specific area
% where there communication between agents is possible). The regular
% algorithm uses a radius of communication, where if some agent i is within
% the radius of communication of agent j, they can communicate with one
% another. If you wish to change the way in which communication between
% agents is established go to line 32 to change this (that is, if you have 
% selected 'Custom Algorithm' in the GUI).
% communication: This function decomposes the communication graph into sets
% of agents for which communication is possible, i.e. if agent i can
% communicate with agent j (note that paths between agents are possible),
% then these agents belong to the same set. The total number of sets is the
% variable n_connected_subgraphs. 'communication' is then a cell array
% where the i^th cell is the i^th set of connected agents. Each cell is a
% vector where the entries of the vectors are the indices of the connected
% agents.
%% com_mat
com_mat = zeros(Number_of_Agents,Number_of_Agents); % This is the adjacency matrix
if algorithm_type == 1
    for i = 1:Number_of_Agents
        for j = i:Number_of_Agents
            if (Agent_Positions(j,1)-Agent_Positions(i,1))^2 + (Agent_Positions(j,2)-Agent_Positions(i,2))^2 <= r_c^2
                com_mat(i,j) = 1;
                com_mat(j,i) = 1;
            end
        end
    end
%% Editable com_mat
elseif algorithm_type == 2
        for i = 1:Number_of_Agents %%%%%%% Your code goes here!%%%%%%%%%%%%%%%%%%
        for j = i:Number_of_Agents
            if (Agent_Positions(j,1)-Agent_Positions(i,1))^2 + (Agent_Positions(j,2)-Agent_Positions(i,2))^2 <= r_c^2
                com_mat(i,j) = 1;
                com_mat(j,i) = 1;
            end
        end
    end 
end
%% Creating communication cell
% Now we determine the number of groups:
connected_graph_decomp = scomponents(com_mat); % The i^th entry is the subgraph to which agents i belongs to.
n_connected_subgraphs = max(connected_graph_decomp); % number of connected subgraphs
n_agents_in_subgraph = zeros(1,n_connected_subgraphs); % number of agents/subgraph, subgraph i contains the number of agents in the i^th entry of this array
k = 1;
for i = 1:size(connected_graph_decomp,1) % This will output the number of agents in each subgraph
    if i > 1
        if connected_graph_decomp(i) > max(connected_graph_decomp(1:i-1))
            k = k + 1;
            for j = i:size(connected_graph_decomp,1)
                if connected_graph_decomp(i) == connected_graph_decomp(j)
                       n_agents_in_subgraph(k) = n_agents_in_subgraph(k) + 1;
                end
            end
        end
    elseif i == 1
        k = 1;
        for j = i:size(connected_graph_decomp,1)
            if connected_graph_decomp(i) == connected_graph_decomp(j)
                n_agents_in_subgraph(k) = n_agents_in_subgraph(k) + 1;
            end
        end
    end
end

communication = cell(1,n_connected_subgraphs);
for i = 1:n_connected_subgraphs % Sets up sizes for cell array
    communication{1,i} = zeros(n_agents_in_subgraph(1,i),1);
end

% Puts agent index in cell array for connected agents
for i = 1:n_connected_subgraphs
    k = 1;
    for j = 1:size(connected_graph_decomp,1)
        if connected_graph_decomp(j) == i
            communication{1,i}(k,1) = j;
            k = k+1;
        end
    end
end

% Orders communication cell
communication = order_com_cell(Agent_Positions,communication,n_connected_subgraphs,n_agents_in_subgraph);

end