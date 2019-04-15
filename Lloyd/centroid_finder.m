function Centroids = centroid_finder(Agent_Points, Mass, Density, Number_of_Robots, Agent_Positions)
% Centroids is a nx2 matrix, where (i,1) and (i,2) represent the ith
% agent's centroid's x and y value, respectively.

% Calculates Sum(x*D(x,y)), then divides by mass to get x centroid, does 
% the same to get y centroid. This follows the accepted equation for
% centroid of an area. 

Centroids = zeros(Number_of_Robots, 2);
Centroid_sum = zeros(Number_of_Robots, 2);
nonzero_centroids = [];
for i = 1:Number_of_Robots 
    for j = 1:size(Agent_Points{1,i},1)
        x_density = floor(Agent_Points{1,i}(j,1));
        y_density = floor(Agent_Points{1,i}(j,2));
        x = Agent_Points{1,i}(j,1);
        y = Agent_Points{1,i}(j,2);
        if x_density > 0 && y_density > 0
            Centroid_sum(i,1) = Centroid_sum(i,1) + x*Density(x_density,y_density) ;
            Centroid_sum(i,2) = Centroid_sum(i,2) + y*Density(x_density,y_density) ;
            
            
                
           
          

        end
    end
end

for i = 1:Number_of_Robots
    if Mass(i) == 0 % If robot has no surrounding mass then don't move it.
        
        Centroids(i,1) = Agent_Positions(i,1);
        Centroids(i,2) = Agent_Positions(i,2);
    else % Otherwise, calculate the centroid.
        Centroids(i,1) = Centroid_sum(i,1)/Mass(i);
        Centroids(i,2) = Centroid_sum(i,2)/Mass(i);
        
        if Centroids(i,1) ~=0 && Centroids(i,2) ~=0
            nonzero_centroids = [nonzero_centroids; Centroids(i,:)];

        end

    end
end

size_c = size(nonzero_centroids);


for i = 1:Number_of_Robots
    if Centroids(i,1) ==0 && Centroids(i,2) ==0
        if size_c(1) ~=0
            idx = randi([1 size_c(1)], 1);
            disp(idx)
            Centroids(i,:) =nonzero_centroids(idx,:);
        end

    end

end