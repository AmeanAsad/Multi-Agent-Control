function [Agent_Positions, D, fire_spread] = Density_Position_Generator(Number_of_Robots,sides)
syms x y z
import py.mat_fire_model.fire_model

fire_spread = fire_model(int16(sides));
fire_spread.initialize_fire();   
D = double(fire_spread.take_fire_step());
save('density.mat','D');
    


Agent_Positions = zeros(Number_of_Robots,2);
for i = 1:Number_of_Robots
    Agent_Positions(i,1) = int16(rand(1,1)*(sides));
    Agent_Positions(i,2) = int16(rand(1,1)*(sides));
end

end
