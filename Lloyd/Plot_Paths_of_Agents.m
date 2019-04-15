clear all
Points = xlsread('agentData.xlsx');
Number_of_Agents = size(Points,2)/2;



%{
%% Partitioning of Points
Partitioned_Points = cell(1,Number_of_Agents); %Initialize cell array with point partitions
                               %each cell contains a 2x2 array which
                               %contain the x,y positions of the
                               %partitioned points.
Polynomials = cell(1,Number_of_Agents);
degrees = cell(1,Number_of_Agents);
for i = 1:Number_of_Agents
    Partitioned_Points{1,i} = cell(1,1);
    Partitioned_Points{1,i}{1,1} = Points(1,(2*i)-1:2*i);
    Polynomials{1,i} = cell(1,1);
end

phi = pi/1.5;
for k = 1:Number_of_Agents
    l = 1;
    for i = l+1:size(Points,1)  
        s_x0 = (Points(l+1,(2*k)-1)-Points(l,(2*k)-1))/...
            (abs(Points(l+1,(2*k)-1)-Points(l,(2*k)-1))); % Starting x increase/decrease to do vertical line test
        s_xi = (Points(i,(2*k)-1) - Points(i-1,(2*k)-1))...
            /(abs(Points(i,(2*k)-1)-Points(i-1,(2*k)-1)));
        x_i = Points(i,(2*k)-1) - Points(i-1,(2*k)-1);
        y_i = Points(i,2*k) - Points(i-1,2*k);
        angle = atan(y_i/x_i);
        if s_xi ~= s_x0 || angle >= phi
            l = l + 1;
            Partitioned_Points{1,k}{l,1} = Points(i-1:i,(2*k)-1:2*k);
        else
            Partitioned_Points{1,k}{l,1} = vertcat(Partitioned_Points{1,k}{l,1},Points(i,(2*k)-1:2*k));
        end
    end
end
%% Find how many max's and min's there are in each partition to determine 
% degree of the polynomial used in polyfit. The array of degrees is
% initialized with ones since the degree of the desired polynomial will be
% the number of local maxima and minima + 1.
for k = 1:Number_of_Agents
    degrees{1,k} = ones(1,size(Partitioned_Points{1,k},1));
end

for k = 1:Number_of_Agents
    for i = 1:size(Partitioned_Points{1,k},1)
        if size(Partitioned_Points{1,k}{i,1},1) > 2
            for l = 2:size(Partitioned_Points{1,k}{i,1},1)-1
                s_ylm1 = (Partitioned_Points{1,k}{i,1}(l,2) - ...
                    Partitioned_Points{1,k}{i,1}(l-1,2))/...
                    abs(Partitioned_Points{1,k}{i,1}(l,2) - ...
                    Partitioned_Points{1,k}{i,1}(l-1,2));
                s_ylp1 = (Partitioned_Points{1,k}{i,1}(l+1,2) - ...
                    Partitioned_Points{1,k}{i,1}(l,2))/...
                    abs(Partitioned_Points{1,k}{i,1}(l+1,2) - ...
                    Partitioned_Points{1,k}{i,1}(l,2));
                if s_ylm1 ~= s_ylp1
                    degrees{1,k}(1,i) = degrees{1,k}(1,i) + 1;
                end
            end
        end
    end
end


%% Build Polynomials


for k = 1:Number_of_Agents
    for i = 1:size(Partitioned_Points{1,k},1)
        Polynomials{1,k}{i,1} = polyfit(Partitioned_Points{1,k}{i,1}(:,1),...
            Partitioned_Points{1,k}{i,1}(:,2),degrees{1,k}(1,i));
    end
end
            
%% Plot Polynomials
x_polys = cell(1,Number_of_Agents);
y_polys = cell(1,Number_of_Agents);
for k = 1:Number_of_Agents
    x_polys = cell(1,1);
    y_polys = cell(1,1);
end
for k = 1:Number_of_Agents
    for i = 1:size(Partitioned_Points{1,k},1)
        x_polys{1,k}{i,1} = linspace(min(Partitioned_Points{1,k}{i,1}(:,1)),...
            max(Partitioned_Points{1,k}{i,1}(:,1)),100);
    end
end

for k = 1:Number_of_Agents
    for i = 1:size(Partitioned_Points{1,k},1)
        figure(k+1);
        y_polys{1,k}{i,1} = polyval(Polynomials{1,k}{i,1},x_polys{1,k}{i,1});
        %hold on
        %plot(Partitioned_Points{1,k}{i,1}(:,1),...
        %    Partitioned_Points{1,k}{i,1}(:,2));
        hold on
        plot(x_polys{1,k}{i,1},y_polys{1,k}{i,1});
    end
end
%}