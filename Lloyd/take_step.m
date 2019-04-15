function [step_position] = take_step(cell,wind_direction ,wind_speed)
% Don't worry about it 

 potential_steps = [
            [0,0];
            [0,1];
            [1,1];
            [1,0];
            [0,-1];
            [-1,-1];
            [-1,0];
            [-1,1];
            [1,-1];
            ];
        
  
  for  i = 1:wind_speed/4
      potential_steps = [potential_steps; wind_direction];
      
  end
  
  size_of_steps = size(potential_steps);
  
  idx = randi([1 size_of_steps(1)],1);
  step = potential_steps(idx,:);
  
  step_position = step + cell;
  disp(cell);
  disp(step);
  disp(step_position);
      
   
end

