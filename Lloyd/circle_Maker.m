  function [] = circle_Maker(x_centre,y_centre,r_o)
    % Draws a circle of specified radius around point (x_centre,y_centre)
    
    theta = linspace(0,2*pi,100);
    x = r_o.*cos(theta) + x_centre;
    y = r_o.*sin(theta) + y_centre;
    
    plot(x,y,'magenta')
    end