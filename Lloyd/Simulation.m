
movement_scale = 1.8;
sides = int16(100);
r_c = 30;
robot_number = 15;
r_o = 30;
velocity = 5;
max_velocity = 10;
delay = 1;
E = ones(15,1);
iteration_number = 50;
[Agent_Positions, Density, fire_model] = Density_Position_Generator(robot_number,sides);
syms x y z
[yy,xx] = meshgrid(linspace(0,double(100),double(100)));
Agent_Positions = Fixing_Starting_Positions(Agent_Positions, sides);
colours_energy = zeros(robot_number,3);
for i = 1:robot_number
    colours_energy(i,:) = rand(1,3); % Generate colours for energy example
end
% 
% f1 = figure('Name','Measured Data','NumberTitle','off');
% figure(f1);

for i = 1:iteration_number
    distance_travelled = 0;
    
    [com_mat, coms] = communication_fun(Agent_Positions, r_c, robot_number,1);
    Agent_Points = assign_points(Agent_Positions, com_mat, sides, 1,r_o,1,E);
    mass =  mass_calc(Agent_Points, Density, robot_number);
    covered_mass = covered_mass_fun(Agent_Positions,Density,...
    r_o,robot_number);
    centroids = centroid_finder(Agent_Points, mass, Density, robot_number, Agent_Positions);
    [Agent_Positions, distance_travelled, E] = move_agents( Agent_Positions, centroids, ...
        distance_travelled, 1, velocity,max_velocity,movement_scale,1,E );
    

%     
%     for n = 1:robot_number % Plot Agents and centroids
%         hold on
%         scatter(Agent_Positions(n,1),...
%             Agent_Positions(n,2),90,'blue','filled');
%         XLim = [0 sides];
%         YLim = [0 sides];
%         label_agent_index = num2str(n);
%         t.FontSize = 20;
%         text(double(Agent_Positions(n,1)) + double(sides/65),...
%             double(Agent_Positions(n,2)) + double(sides/65), label_agent_index);
%         hold('on')
%         scatter(centroids(n,1),centroids(n,2),50,'red','filled');  
%         hold('on')
%         
%         theta = linspace(0,2*pi,100);
%         x = r_o.*cos(theta) + Agent_Positions(n,1);
%         y = r_o.*sin(theta) + Agent_Positions(n,2);
%         
%         plot(x,y,'magenta')
%     
%         circle_Maker(Agent_Positions(n,1), Agent_Positions(n,2),r_o); 
%     end
%     
%     hold('on')
%     voronoi(Agent_Positions(:,1),Agent_Positions(:,2))
%     %hold('on')
%      % h is used for line width
%     drawnow
%     cla(f1);
%     clf(f1);
    
    
    Density = iteration_variation_fun(Density,iteration_number,...
    1,fire_model, Agent_Positions,r_o);

    
   
    
end


omitted = 0;
still = 0;
for n =1:100
    for z =1:100
        if Density(n,z) ~=0
            
            if Density(n,z) < 0.6
                omitted = omitted + 1;
            else
                still = still + 1;
        
            end
        end
    end
end

    

contour(xx,yy,Density)
percentage = omitted/(still+omitted);
disp(percentage);
