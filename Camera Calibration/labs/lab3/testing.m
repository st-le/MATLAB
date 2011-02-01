% @t: 2x1-translation vector 
% @P: matrix of points that should be transformed: 
% P = [x1 x2 x3 ... xn
%      y1 y2 y3 ... yn]
% @Pr: matrix of transformed points

Rec = [0 0 1 1 0
       0 1 1 0 0
       1 1 1 1 1];


% % Rotation by phi
% R = [ cos(phi) -sin(phi) 0
%       sin(phi)  cos(phi) 0
%       0         0        1];
% 
% Translation     
T = [ 1 0 -3
      0 1 -1
      0 0 1];     
% 
% RT = R*T;

%Pr = inv(T)*RT*P;

% scaling by (4,2)
S = [4 0 0
     0 2 0
     0 0 1];

 s = T*S*Rec;
 hold on;
 plot(Rec(1,:), Rec(2,:),'r')
 plot(s(1,:), s(2,:),'g')
 axis equal
 axis([-10 15 -10 15]);