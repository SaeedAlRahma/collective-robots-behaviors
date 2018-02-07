# Collective Robots Behaviors
Circular robots form a flock and move together through a marked course to a goal location with minimal collisions between each other

## RUNNING SIMULATION ##
This simulation was completed using MATLAB. In order to run the simulation:
1) Open Matlab
2) Go to the directory containing the code
3) Open collectivity.m
4) Run the script (green play sign under the editor tab)

The script will open a figure, plot environment, and animate it as robots move (simulation period is 0.25 seconds, but each frame is 1 second).

Extra features:
* Hide the path markers: follow the documentation in code in one place where it says, “COMMENT THESE LINES…”
* Show centroid marker: follow the documentation in code in two places where it says, “UNCOMMENT THESE LINES…”
	
## Scenario Description ##
Description: 25 holonomic circular robots of radius 0.25 m with 360-degree field of view sensors of range 50 m must form a flock and move together through a marked course to a goal location with minimal collisions between each other.

Assumptions: The sensing of each robot is perfect, and they all may home toward both the line through the course and the goal location, but that each robot may not explicitly communicate with any other robot.

Goal: Minimize the average distance of each robot from the centroid of the distribution of robots without colliding and minimize the distance of the centroid from the closest point on the line at each time step while making progress toward the goal location.
Description: m holonomic robots with 360-degree field of view sensors of range do3 must observe n holonomic targets moving randomly within a circular environment of radius R. The speed of each target is fixed and randomly chosen to be between 0 m/s and 1.5 m/s. The maximum speed of each robot is 2 m/s.

## SIMULATION DESIGN ##
The flocking design relied on homing and dispersion to achieve the robots goal. The implementation was designed carefully to avoid any possible collisions using the dispersion techniques and to guarantee achieving goal using homing techniques. To improve the design even better, an aggregation technique could be implemented to decrease the distance between robots and centroid. However, an aggregation technique might increase the distance between the centroid and the path and cancel the effects of the dispersion techniques leading to some collisions.

## Result Analysis ##
[Demo Simulation - unmarked](https://youtu.be/N_kdF789zJw)

[Demo Simulation - marked centroid](https://youtu.be/A6i-_f6VMCo)

[Demo Simulation - marked path](https://youtu.be/0fmyBX3YHXo)

[Demo Simulation - marked centroid and path](https://youtu.be/5lDIuC-ugkE)

Detailed results in [results.docx](https://github.com/SaeedAlRahma/collective-robots-behaviors/blob/master/results.docx).
