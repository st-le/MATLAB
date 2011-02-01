function [ C_inf, I ] = metric_rectification4( C, l ,Iloc )
%{ 
performs metric rectification on an image at location "Iloc"
by calculating C_infinity_star' using the paper 
"planar metric rectification by algebraically estimating
the image of the absolute conic" by Yisong Chen & Horace S Ip
Assumption: C is an already found "well-fit" image of a real world circle in the image
Main idea: intersect the image of the circle (which in general is an ellipse) C with the line at infinity l
to find I',J'. From these two, construct the conic dual to them, which is of course C_inf_star'
With C_inf_star' we can now do rectification as in our other examples.
@C: ellipse in the image plane C = [a,b,c,d,e,f]
@l: image of l_inf, use findHpl_inf2 to find this
%}

% preparations
a=C(1);b=C(2);c=C(3);d=C(4);e=C(5);f=C(6);
u1 = -l(1)/l(2); u2=-l(3)/l(2);
v1 = -l(2)/l(1); v2=-l(3)/l(1);

% calculate (x0,x1)
p1 = [(a + b*u1 + c*(u1^2)), (b*u2 + 2*c*u1*u2 + d + e*u1), (c*(u2^2) + e*u2 + f)];
x = roots(p1); 
x0=x(1); x1=x(2);

% calculate (y0,y1)
p2 = [(c + b*v1 + a*(v1^2)), (b*v2 + 2*a*v1*v2 + e + d*v1), (a*(v2^2) + d*v2 + f)];
y = roots(p2); 
y0=y(1); y1=y(2);

% now, I' = [x0, y0, 1] and J' = [x1, y1, 1] are known -> construct C_star_inf' = I'*J't + J'*I't
I = [x0, y0, 1]';
J = [x1, y1, 1]';

% get C_inf_star' 
C_inf = I*J' + J*I';

% now, proceed as usual:

% get KKt
KKt = C_inf(1:2,1:2);
% get K
K = chol(KKt,'lower');
% get b
b = [ C_inf(1,3), C_inf(2,3)]';
% solve K*K'*v = b 
v = KKt\b;

% K, v are known -> construct Ha, Hp
Ha = [K [0 0]'
       0 0  1 ];
   
Hp = [eye(2) [0 0]'
      v(1) v(2) 1];   

% invert Hp*Ha to remove perspective (Hp) and affine (Ha) distortion
H = inv(Hp*Ha);

% apply (Hp*Ha)^-1 to the image & display the rectified result
I = rectification(H, Iloc);

end
