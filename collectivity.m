% Saeed Alrahma
% October 31, 2017
% ECE 590-17: Distributed Robotic Systems
% Assignment 2 - Collectivity
%
% I have adhered to the Duke Community Standards in completing this
% assignment

clear;

%% Parameters
% Robot Parameters
num_robots = 25;
robot_radius = 0.25; % in meters
view_range = 50; % in meters
robot_max_velocity = 20; % in meters
robot_area = pi * robot_radius^2;

% Stage Parameters
start = [100 300];
goal = [300 100];
start_circle = [50.*cos(linspace(0,2*pi))+start(1);50.*sin(linspace(0,2*pi))+start(2)];
course_seg1 = [linspace(start(1),goal(1),200); linspace(start(2),start(2),200)];
course_seg2 = [linspace(goal(1),goal(1),200); linspace(start(2),goal(2),200)];
course_path = cat(2, course_seg1, course_seg2);

% Simulation Parameters
sim_interval = 0.25; % in seconds

%% Setup
% Simulation Setup
robot_vel = zeros(2, num_robots); % velocity array of robots
robot_pos = zeros(2, num_robots); % position array of robots
% Spawn robots randomly with 50m of start point
for i=1:num_robots
    robot_pos(:,i) = rand_circ(start(1),start(2),view_range, robot_pos, robot_radius);
end
t = 0; % simulation time (in seconds)
% Set up files to write data
file1ID = fopen('data1.txt','w');
file2ID = fopen('data2.txt','w');
fprintf(file1ID,'Simulation Started! time = 0\n');
fprintf(file2ID,'Simulation Started! time = 0\n');
centroid = write_data(file1ID, file2ID, robot_pos, course_path);

% Figure Setup
f1 = figure(1); clf;
set(gcf, 'Position', [0, 0, 800, 800]);
movegui(f1,'northeast');
axis([0 400 0 400])
set(gca,'Color','k')
grid on
title('Simulation World (in meters)')
hold on

%% Plotting
% Plot Stage (COMMENT THESE LINES TO HIDE PATH)
stage_plot = plot(start_circle(1,:), start_circle(2,:), 'm--', ...
course_path(1,:), course_path(2,:), 'm--', ...
goal(1), goal(2), 'xr', 'MarkerSize', 10);

% Plot Robots
robot_scatter = scatter(robot_pos(1,:),robot_pos(2,:), 'w', 'filled');

% Plot Centroid (UNCOMMENT THIS LINE TO SHOW CENTROID)
% centroid_marker = plot(centroid(1), centroid(2), '*y', 'MarkerSize', 10);

% Size robots properly
currentunits = get(gca,'Units');
set(gca, 'Units', 'Points');
axpos = get(gca,'Position');
set(gca, 'Units', currentunits);
markerWidth = (robot_radius.*2)/diff(xlim)*axpos(3);
set(robot_scatter, 'SizeData', markerWidth^2)

hold off
pause(5);
%% Simulatation       
% Simulate until goal is reached (within 7 meters)
while (pdist2(centroid, goal, 'euclidean') > 7) 
    %% Control (Flocking)
    t = t+1;
    
    % homing
    robot_vel = homing(robot_pos, course_path, robot_max_velocity);
    
    % dispersion
    robot_vel = dispersion(robot_pos, robot_vel, view_range, robot_radius);
        
    % Move robots
    robot_pos = robot_pos + robot_vel; % move one sec
    
    % Centroid calculations
    centroid = write_data(file1ID, file2ID, robot_pos, course_path);

    
    %% Animation
    pause(sim_interval) % Wait "sim_interval" seconds
    % update robots' positions on plot
    set(robot_scatter,'XData',robot_pos(1,:));
    set(robot_scatter,'YData',robot_pos(2,:));
    % update centroid's position on plot (UNCOMMENT THESE LINES TO SHOW
    % CENTROID)
%     set(centroid_marker,'XData',centroid(1));
%     set(centroid_marker,'YData',centroid(2));
    drawnow
end

%% Close files
fprintf(file1ID,'Simulation Ended! time = %d\n', t);
fprintf(file2ID,'Simulation Ended! time = %d\n', t);
fclose(file1ID);
fclose(file2ID);
disp('Simulation Finished!')