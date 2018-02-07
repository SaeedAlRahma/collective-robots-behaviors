function vel =homing(pos, path, max_vel)
% the function, must be on a folder in matlab path
% pos is an array with robots' position
% path is the path for robots to follow
    %% Setup variables
    vel = zeros(2,size(pos,2));
    next_pos = zeros(2,size(pos,2));
    
    %% Calculate velocity next sub-goal (next point on path)
    for i=1:size(pos,2)
       d_to_path = sqrt((path(1,:)-pos(1,i)).^2 + (path(2,:)-pos(2,i)).^2);
       [d, ind] = min(d_to_path);
       if((ind+10)>size(path,2))
            next_pos(:,i) = path(:,size(path,2)); 
       else
            next_pos(:,i) = path(:,ind+10);
       end
       theta = atan2((next_pos(2,i)-pos(2,i)), (next_pos(1,i)-pos(1,i)));
       v = (d*(d<max_vel)) + (max_vel*(d>=max_vel)); % cap velocity
       vel(1,i) = max_vel*cos(theta);
       vel(2,i) = max_vel*sin(theta);
    end
end