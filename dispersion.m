function vel =dispersion(robots, vel_i, range, rad)
% the function, must be on a folder in matlab path
% robots is an array with robots' position
% vel_i is an array with robots' velocity
% range is max range view
% rad is the radius of the robot

    %% Setup variables
    vel = vel_i;
    d_robs = dist(robots); % distance between all robots
    ang_robs = zeros(size(robots,2)); % angle between all robots
    for i=1:size(robots,2) % find angles between all robots
        ang_robs(i,:) = atan2(robots(2,:)-robots(2,i), robots(1,:)-robots(1,i));
    end
    % View range data (-1 is out of range)
    robs_view = (d_robs.*(d_robs<=range)) + (-1.*(d_robs>range));
    
    %% Dispersion
    vel_dsp = ((-0.04.*robs_view)+2).*(robs_view>0); % ignore self (d=0)
    vel_cmp = vel_dsp.*cos(ang_robs); % velocity x component
    vel_cmp(:,:,2) = vel_dsp.*sin(ang_robs); % velocity y component
    vel_sum = sum(vel_cmp); % sums all columns by default
    
    %% Fill return values
    vel(1,:) = vel(1,:) + vel_sum(:,:,1);
    vel(2,:) = vel(2,:) + vel_sum(:,:,2);
end