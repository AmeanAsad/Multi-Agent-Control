function Mass = mass_calc(Agent_Points, Density, Number_of_Robots)
% Outputs a vector with the mass of the region of agent i stored in 
% Mass(i).

% Density: sides*Partition_Number X sides*Partition_Number array,
% where the entry of the matrix at i,j is the value of the density at 
% (i/p,j/p) You must have your data represented in this way in order for 
% this function to work.


Mass = ones(1,Number_of_Robots);

for i = 1:Number_of_Robots
    for j = 1:size(Agent_Points{1,i},1)
        x = floor(Agent_Points{1,i}(j,1));
        y = floor(Agent_Points{1,i}(j,2));
        if x > 0 && y > 0
            Mass(i) = Mass(i) + Density(x,y);
        end
     end
end

end

            
            
        
        