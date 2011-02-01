function  [ normpts, T ]  = normalizepts( pts )
%{ 
   VERIFIED
    normalizes the input points in the following form:
       1. translation of all points s.t. their centroid is the origin
       2. scaling of all points s.t. their average distance from the origin is sqrt(2)
       3. create a similarity transformation T from 1. and 2. and apply it to all pts.
            pts = [ x1		 xn  			
				    y1	...	 yn  						 
				    w1		 wn ]	
	output:
    @ normpts: the points normalized with T
    @ T: the similarity transformation T that normalizes the points
    T = S*T_, where T_ is a translation and S is a scaling
%}

% initialize T
Tt = eye(3);
% calculate centroid -> translation component known
t = [-mean(pts(1,:)), -mean(pts(2,:))];
Tt(1:2,3) = t;

% translate points
pts = Tt*pts;
% compute scaling -> scaling component of T known

% avgdistance from origin = 1/m * sum(norm(x)), where m = # points
% compute norm of each vector
nx = sqrt(sum(pts(1:2,:).^2));
% we want avgdist_from_O = s * (1/m) * sum(norm(x)) = sqrt(2) 
% <-> s = sqrt(2) / (1/m) * sum(nx) = sqrt(2) / mean(nx)
s = sqrt(2) / mean(nx);

% construct T from t and s
Ts = [s 0 0
     0 s 0 
     0 0 1];
% translation followed by scaling
T = Ts*Tt;
normpts = Ts*pts;
end
