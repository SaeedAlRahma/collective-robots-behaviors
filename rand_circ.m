function pos=rand_circ(x1,y1,rc,robs,rad)
%the function, must be on a folder in matlab path
% x1,y1 are the circle center
% rc is the circle radius
% robs is a list of all robots in the simulation
    success = false;
    while (~success)
        % generate random point
        a=2*pi*rand;
        r=sqrt(rand);
        pos(1)=(rc*r)*cos(a)+x1;
        pos(2)=(rc*r)*sin(a)+y1;
        
        % check collision
        d = dist(robs);
        d = 1.*(d>0).*(d<(2.*rad));
        if (~max(d))
            success = true; % no collision
        end
    end
end