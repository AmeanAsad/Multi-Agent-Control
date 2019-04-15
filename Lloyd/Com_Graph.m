function [] = Com_Graph(Agent_Positions,coms,com_mat,handles,sides)
% We first make the necessary amount of colours:
n_connected_subgraphs = size(coms,2);

for i = 1:n_connected_subgraphs
    colours(i,:) = rand(1,3);
end
axes(handles.com_figure)
for i = 1:size(Agent_Positions,1)
    hold on
    scatter(handles.com_figure,Agent_Positions(:,1),Agent_Positions(:,2));
    label_agent_index = num2str(i);
    text(Agent_Positions(i,1) + sides/65, Agent_Positions(i,2) + sides/65,...
        label_agent_index);
end
for i = 1:n_connected_subgraphs
    for j = 1:size(coms{1,i},1)
        for k = 1:size(coms{1,i},1)
            if com_mat(coms{1,i}(j,1),coms{1,i}(k,1)) == 1 
                    x1 = Agent_Positions(coms{1,i}(j,1),1);
                    y1 = Agent_Positions(coms{1,i}(j,1),2);
                    x2 = Agent_Positions(coms{1,i}(k,1),1);
                    y2 = Agent_Positions(coms{1,i}(k,1),2);
                    axes(handles.com_figure)
                    hold on
                    plot(handles.com_figure,[x1 x2],[y1 y2],'Color',colours(i,:));
            end
        end
    end
end



end