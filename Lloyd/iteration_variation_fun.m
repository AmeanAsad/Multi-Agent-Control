function Density = iteration_variation_fun(Density,iteration_number,...
    delay,fire_spread, Agent_Positions,r_o)
% This function will run through your Density matrix every
% iteration. Since the Density matrix is discretized depending on the
% Partition Number chosen, the (x,y) values of the (i,j) entry of the
% Density matrix are: x = i/Partition_Number, and y = j/Partition_Number.
% Hence, to change a density value at position (x,y) we calculate first the
% (x,y) position as above, then change the Density value according to some
% function which takes in position and iteration number, for example;
% Density(x,y,iteration_number) = (x+iteration_number)^2 +
% (y-iteration_number)^2. Keep in mind that the density must always be
% greater than or equal to 0. If you want the density only to change after
% a certain number of iterations (you may want to for example change the
% density every 5 iterations), then this number is the delay value, and
% this function will only change the density if delay divides the iteration
% number.
% NOTE 1: Another idea for using variable density is to change the density
% if, when the agents pass over some area, they lower the density (this
% highly depends on your application). To do this, you would have to use
% the current positions of the agents, stored in Agent_Positions, 
% which is an n x 2 matrix with the indices of the agents as rows,
% x-position for the first column, and y-position for the second column. 
% NOTE 2: Density is being constantly updated every iteration, therefore
% the value of Density at iteration k is Density(x,y,k), in this function
% you would want to generate Density(x,y,k+1).
syms x y z
[yy,xx] = meshgrid(linspace(0,double(100),double(100)));
change = mod(iteration_number,delay); %Checks if iteration_number divides delay.
if change == 0
   for i = 1:2
          D = double(fire_spread.take_fire_step());   
   end
%     contour(xx,yy,D);
    Density = D;

    for i = 1:size(Density,1)
        for j = 1:size(Density,1)
            x = i;
            y = j;
            %%%%% This is where you put your custom function!%%%%
            %% Internal Density change due to agents
            check = 0;
            for k = 1:size(Agent_Positions,1)
                if (x - Agent_Positions(k,1))^2 + (y - Agent_Positions(k,2))^2 <= r_o^2 && check == 0
                    Density(i,j) = Density(i,j) - Density(i,j)/size(Agent_Positions,1); %This will halve the density if an agent is covering it
                                                   % Note that only one
                                                   % agent at a time can
                                                   % cover the density
                    if Density(i,j) < 0
                        Density(i,j) = 0;
                    end
                    check = 1;
                end
            end
      
       end
    end
    
    
    
    save('density.mat','D');
    %contour(xx,yy,Density);
%     drawnow

end