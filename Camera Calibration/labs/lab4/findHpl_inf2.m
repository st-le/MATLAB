function [l, R] = findHpl_inf2( Iloc, P1, P1t, P2, P2t )
%{ 
removes the perspective distortion from an image at Iloc.
this is also called affine rectification.

we first find the image of the line at infinity (called Hp(l_inf)).
with this, we can calculate the transformation that removes the perspective distortion.

--- Parameters: ---
@Iloc: location of the image for which we wish to remove the perspective distortion
@P1, P2: matrices with points on one line (2D-hom) in the order a,b,c
P1 = [ax bx cx      P2 = [dx ex fx
      ay by cy]         dy ey fy] 
@P1t, P2t: matrices with transformed points on the same line (2D-hom).
P1t = [a'x b'x c'x  P2t = [d'x e'x f'x
       a'y b'y c'y]        d'y e'y f'y]
where P1t are the transformed points of P1 (same for P2t,P2).
Furthermore, all points are sorted according to their distance from the line at infinity,
i.e. c is nearest, b is second-nearest and a is farthest away from the line at infinity.
%}

% construct the distance matrices of the real world points and the
% corresponding transformed points

D1 = [0 norm(P1(:,2)-P1(:,1)) norm(P1(:,2)-P1(:,1)) + norm(P1(:,3)-P1(:,2))];

D1t = [0 norm(P1t(:,2)-P1t(:,1)) norm(P1t(:,2)-P1t(:,1)) + norm(P1t(:,3)-P1t(:,2))]; 

D2 = [0 norm(P2(:,2)-P2(:,1)) norm(P2(:,2)-P2(:,1)) + norm(P2(:,3)-P2(:,2))];

D2t = [0 norm(P2t(:,2)-P2t(:,1)) norm(P2t(:,2)-P2t(:,1)) + norm(P2t(:,3)-P2t(:,2))];


% find 2x2 homography matrices
H1 = getH1D(D1,D1t);
H2 = getH1D(D2,D2t);

% get distances from "a" := [0 1] to point at infinity; inhomogenize
d1 = H1*[1 0]'; d1 = d1(1)/d1(2);
d2 = H2*[1 0]'; d2 = d2(1)/d2(2);

% get the points at infinity x1, x2 in 2D:
% Hp(l_inf) in 2D coords can be determined by:
% [a'x; a'y] + d*normalized([b'x - a'x, b'y - a'y, 1]), where d is the distance to the point at infinity from a.
x1 = P1t(:,1) + d1.*(P1t(:,2) - P1t(:,1))./norm(P1t(:,2) - P1t(:,1));
x2 = P2t(:,1) + d2.*(P2t(:,2) - P2t(:,1))./norm(P2t(:,2) - P2t(:,1));

% homogenize x1, x2
x1 = vertcat(x1,1);
x2 = vertcat(x2,1);

% the image of the line at infinity is x1 >< x2
l = cross(x1,x2);
l = l/l(3);

l1 = l(1); l2 = l(2); l3 = l(3);

% we have found Hp(l_inf) = [l1 l2 l3]'
% we can use this now to remove the perspective distortion with 
Hi = [   1      0     0
         0      1     0
      -l1/l3 -l2/l3  1/l3];

% observe the result
R = rectification(Hi,Iloc);

end
