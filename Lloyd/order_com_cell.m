function [communication] = order_com_cell(Agent_Positions,communication,n_connected_subgraphs,n_agents_in_subgraph)

for i = 1:n_connected_subgraphs
    p = 1;
    for j = p:n_agents_in_subgraph(1,i)
        for k = 1:n_agents_in_subgraph(1,i)
            if Agent_Positions(communication{1,i}(j,1),1) < Agent_Positions(communication{1,i}(k,1),1)
                temp1 = communication{1,i}(j,1);
                temp2 = communication{1,i}(k,1);
                communication{1,i}(j,1) = temp2;
                communication{1,i}(k,1) = temp1;
                p = j;
            elseif (Agent_Positions(communication{1,i}(j,1),1) == Agent_Positions(communication{1,i}(k,1),1))...
                    && (Agent_Positions(communication{1,i}(j,1),2) < Agent_Positions(communication{1,i}(k,1),2))
                
                temp1 = communication{1,i}(j,1);
                temp2 = communication{1,i}(k,1);
                communication{1,i}(j,1) = temp2;
                communication{1,i}(k,1) = temp1;
                p = j;
            end
        end
    end
end
end
        