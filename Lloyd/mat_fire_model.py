#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Nov 23 15:44:01 2018

@author: ameanasad
"""

#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Nov 13 18:10:02 2018

@author: ameanasad





"""

import numpy as np
import random 
import matplotlib.pyplot as plt
import matplotlib.animation as animation
import math



def take_step(cell, wind_direction, wind_speed):
    """
    Cell: Tuple of an x,y coordinates of one cell in the grid
    - The function will randomly choose to take a step in the Moore
    neighborhood of the given cell (ie the eight surrounding cells)
    - Returns the position of a new cell that the step was taken in   
    """
    cell = np.array(cell)
    potential_steps = [
            [0,0],
            [0,1],
            [1,1],
            [1,0],
            [0,-1],
            [-1,-1],
            [-1,0],
            [-1,1],
            [1,-1]
            ]
    for i in range(wind_speed//2):
        potential_steps.append(wind_direction)
    # Taking a step is similar to adding 
    step = np.array(random.choice(potential_steps))  
    return step + cell
    

def matrix_edge_detection(matrix, size):
    """
    matrix: Array of the fire spread area
    size: The size of the fire spread matrix
    - Function will return the boundary cells of a spreading fire.
    """  
    boundary = []
    # Size is decreased by 1 to avoid hitting dealing with the edge cases
    for x in range(1,size- 1):
        for y in range(1,size-1):
            if matrix[x][y] >0:
                if cell_edge_detection((x,y), matrix):
                    boundary.append((x,y))
                
    return boundary
            
def remodel_matrix(matrix, new_fire_cells, moisture_matrix):
    """
    matrix: Array of the fire spread area
    new_fire_cells: list of tuples, each tuple representing the x,y coordinates
    of a new cell that has been affected by the fire spread.
    """
    
    for cell in new_fire_cells:
        x = int(cell[0])
        y = int(cell[1])
        matrix[x][y] =  0.5*(moisture_matrix[x][y])
        
    return matrix
    
         
def cell_edge_detection(cell, m):
    """
    Detects if a cell is an edge of a fire growth model by checking the 
    Moore neighborhood of the cell. 
    cell: Tuple of x,y coordinates for a given cell
    m: array o the fire spread area
    
    Returns True if cell is an edge and False if not 
    """ 
    x = cell[0]
    y = cell[1]
    
    matrix_boundaries = [
    m[x][y+1],
    m[x+1][y+1],
    m[x+1][y],
    m[x+1][y-1],
    m[x][y-1],
    m[x-1][y-1],
    m[x-1][y],
    m[x-1][y+1] ]
    
    if any(boundary==0 for boundary in matrix_boundaries):
        return True
    else: 
        return False
    
class node(object):
    
    def __init__(self, x,y):    
        self.x = x
        self.y = y    
    def get_loc(self):     
        return (self.x,self.y)  
    def __str__(self):
        return "< " + str(self.x)  + ', ' + str(self.y) + " >"

class fire_model(object):
    
    def __init__(self, size):  
        self.size = size
        self.spread_area = np.zeros((self.size, self.size))
        self.moisture_matrix = np.true_divide(np.random.rand(self.size,self.size),2)+ np.ones((self.size,self.size))

    def initialize_fire(self):
        x_start = random.randint(1,self.size//2)
        y_start = random.randint(1,self.size//2)
    
        fire_start_location = node(x_start, y_start)
        initial_coord = fire_start_location.get_loc()
        self.spread_area[50, 50]= 1
        
        return self.spread_area
    
    def take_fire_step(self):
        
        boundary  = matrix_edge_detection(self.spread_area, self.size-1)
        new_fire_cells = []
        for cell in boundary:
            new_fire_cells.append(take_step(cell, [-1,0],40))
            
        self.spread_area = remodel_matrix(self.spread_area, new_fire_cells, self.moisture_matrix)
        return self.spread_area
    
    def get_area(self):
        return self.spread_area



fig = plt.figure()
ax0 = fig.add_subplot(1,1,1)

global a
a = fire_model(100)
start_coordinates = a.initialize_fire()
print(start_coordinates)
#ax1.title(" Fire simulation with initalized start at: ")

def animate(i):
   
    g = np.zeros((0,0))
    
    a.take_fire_step()
    g  = a.get_area()
    ax0.clear() 
    ax0.imshow(g, cmap='hot',  interpolation='bilinear')
ani = animation.FuncAnimation(fig, animate, interval=20)
plt.show()


fire = fire_model(100)

n = fire.initialize_fire()
for i in range(100):
    fire.take_fire_step()
    




class area_model(object):
    
    def __init___(self, size):
        self.area_matrix = np.zeros((self.size, self.size))
        
    def generate_model(self):
        
        
        pass
    
    def return_model(self):
        
        return self.area_matrix
 

def cluster_generator(cluster_number, size, sample_points, bounding_box):
    
    density_matrix = np.zeros((size,size))
    cluster_points = []
    house_locations = []
    for i in range(cluster_number):
        x = random.randint(bounding_box+1,size-(bounding_box +1))
        y = random.randint(bounding_box+1,size-(bounding_box + 1))
        cluster_points.append((x,y))
        
    for cluster_point in cluster_points:
        
        for cell in range(random.randint(0,sample_points//4)):
           
            center_x = cluster_point[0]
            center_y = cluster_point[1]
            new_cell_x = random.randint(center_x-(bounding_box-1), center_x + (bounding_box-1))
            
            new_cell_y = random.randint(center_y-(bounding_box-1), center_y + (bounding_box-1))
            house_locations.append((new_cell_x,new_cell_y))
            density_matrix[new_cell_x][new_cell_y] = 0.5
        
    return density_matrix, house_locations


def moore_neighberhood_increase(m, cell_locations):
    
    for location in cell_locations:    
        x = location[0]
        y = location[1]  
        m[x][y+1] += 1
        m[x+1][y+1] +=1
        m[x+1][y] += 1
        m[x+1][y-1] += 1
        m[x][y-1] += 1
        m[x-1][y-1] += 1
        m[x-1][y] += 1
        m[x-1][y+1] += 1
    
    return m 
 
d, locations = cluster_generator(20,100, 400, 5)  


final_area = fire.get_area()


f = moore_neighberhood_increase(d, locations)



m = np.multiply(f,final_area)
fig = plt.figure()
ax1 = fig.add_subplot(1,1,1)
ax1.matshow(final_area, cmap='hot',  interpolation='bilinear')
plt.show()


fig = plt.figure()
ax2 = fig.add_subplot(1,1,1)
ax2.matshow(f, cmap='YlGnBu',  interpolation='bilinear')
plt.show()

fig = plt.figure()
ax3 = fig.add_subplot(1,1,1)
ax3.matshow(m, cmap='YlGnBu',  interpolation='bilinear')
plt.show()




