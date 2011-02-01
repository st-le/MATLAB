function [ I, Hp ] = metric_rectification3( L,M,Iloc )
% removes only perspective distortion from image at Iloc
% uses example 2.27 from MVG (without removing the affine distortion)
% @Iloc: image location
% @L,M: matrices containing imaged line pairs (li,mi) that are orthogonal in the world plane of the form
% L = [l1(1) l2(1) ... l5(1);  M = [m1(1) m2(1) ... m5(1);
%      l1(2) l2(2) ... l5(2);       m1(2) m2(2) ... m5(2);
%      l1(3) l2(3) ... l5(3)]       m1(3) m2(3) ... m5(3)]
% where l1 is orthogonal to m1, l2 orthogonal to m2 etc.

% construct equation system from above constraints
A = [];
for i=1:5
    l = L(:,i);
    m = M(:,i);
    a = [ l(1)*m(1), (l(1)*m(2) + l(2)*m(1))/2, l(2)*m(2), (l(1)*m(3) + l(3)*m(1))/2, (l(2)*m(3) + l(3)*m(2))/2, l(3)*m(3)];  
    A = vertcat(A,a); 
end
% find c = (a,b,c,d,e,f)'
s = null(A);
% construct the transformed dual conic C_infinity_star'
a = s(1);b = s(2);c = s(3);d = s(4);e = s(5);f = s(6);
C = [ a  b/2 d/2
     b/2  c  e/2
     d/2 e/2  f ];

% get KKt
KKt = C(1:2,1:2);
% get b
b = [ C(1,3), C(2,3)]';
% solve K*K'*v = b 
v = KKt\b;

% v known -> construct Hp
   
Hp = [eye(2) [0 0]'
      v(1) v(2) 1];   

% invert Hp to remove perspective distortion
H = inv(Hp);

% apply Hp^-1 to the image and display result
I = rectification(H, Iloc);


end
