function Pr = transform(t,phi,P)
% @t: 2x1-translation vector 
% @P: matrix of points that should be transformed: 
% P = [x1 x2 x3 ... xn
%      y1 y2 y3 ... yn]
% @Pr: matrix of transformed points

% Rotation by phi
R = [ cos(phi) -sin(phi) 0
      sin(phi)  cos(phi) 0
      0         0        1];

% Translation     
T = [ 1 0 t(1)
      0 1 t(2)
      0 0 1];     

RT = R*T;

Pr = inv(T)*RT*P;

