function [delta_x, delta_y] = velocity_fun(Velocity_Type,direction_Vector,velocity,max_velocity,MOVEMENTSCALE,algorithm_type)
% Velocity Types: 
% 1: Constant Velocity determined in GUI.
% 2: Velocity is proportional to distance between agent and centroid.
% MOVEMENTSCALE determines the proportion of the distance.
% max_velocity is the bound for velocity
% You may change the way in which the agents move towards the centroid of
% their corresponding area. direction is a vector with x and y components
% that points from the agent's position to the centroid of its assigned
% area. An example for changing this function may be to make it 
% proportional to the Density (in which case Density should be an input to
% this function). Go to line 31 to make changes.
if algorithm_type == 1
    if Velocity_Type == 1
        if(velocity > max_velocity)
            velocity = max_velocity;
        end
        if direction_Vector == [0,0]
            delta_x = 0;
            delta_y = 0;
        else
            delta_x = direction_Vector(1)/sqrt(direction_Vector(1)^2+direction_Vector(2)^2)*velocity;
            delta_y = direction_Vector(2)/sqrt(direction_Vector(1)^2+direction_Vector(2)^2)*velocity;
        end
    elseif Velocity_Type == 2
        delta_x = direction_Vector(1)*MOVEMENTSCALE;
        delta_y = direction_Vector(2)*MOVEMENTSCALE;
        if(sqrt(delta_x^2 + delta_y^2) > max_velocity) % max velocity has been exceeded
            direction_Vector(1) = direction_Vector(1)/(sqrt(direction_Vector(1)^2+direction_Vector(2)^2));
            direction_Vector(2) = direction_Vector(2)/(sqrt(direction_Vector(1)^2+direction_Vector(2)^2));
            delta_x = direction_Vector(1)*max_velocity;
            delta_y = direction_Vector(2)*max_velocity;
        end
       
    end
%% Editable velocity 
elseif algorithm_type == 2
    %%%%%%%%%%%%%% Your velocity type here!%%%%%%%%%%%%%%%%
    if Velocity_Type == 1
        if(velocity > max_velocity)
            velocity = max_velocity;
        end
        delta_x = direction_Vector(1)/sqrt(direction_Vector(1)^2+direction_Vector(2)^2)*velocity;
        delta_y = direction_Vector(2)/sqrt(direction_Vector(1)^2+direction_Vector(2)^2)*velocity;
    elseif Velocity_Type == 2
        delta_x = direction_Vector(1)*MOVEMENTSCALE;
        delta_y = direction_Vector(2)*MOVEMENTSCALE;
        if(sqrt(delta_x^2 + delta_y^2) > max_velocity) % max velocity has been exceeded
            direction_Vector(1) = direction_Vector(1)/(sqrt(direction_Vector(1)^2+direction_Vector(2)^2));
            direction_Vector(2) = direction_Vector(2)/(sqrt(direction_Vector(1)^2+direction_Vector(2)^2));
            delta_x = direction_Vector(1)*max_velocity;
            delta_y = direction_Vector(2)*max_velocity;
        end
    end
end
end