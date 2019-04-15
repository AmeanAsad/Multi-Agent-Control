function [] = Plot_Assigned_Points(Agent_Points, Number_of_Agents,...
    colours_energy,Agent_Positions,sides)

for i = 1:Number_of_Agents
    figure(1)
    title('Assigned Points');
    xlabel('x');
    ylabel('y');
    axis([0 sides 0 sides])
    hold on
    scatter(Agent_Points{1,i}(:,1),Agent_Points{1,i}(:,2),...
        'MarkerEdgeColor',colours_energy(i,:));
    hold on
    scatter(Agent_Positions(i,1),Agent_Positions(i,2),50,...
        colours_energy(i,:),'filled','diamond')
    label_agent_index = num2str(i);
    t.FontSize = 15;
    text(double(Agent_Positions(i,1)) + double(sides/65), double(Agent_Positions(i,2)) + double(sides/65),...
                label_agent_index);
    
end



