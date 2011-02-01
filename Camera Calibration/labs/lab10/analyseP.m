function [ K,R,Ct, focal_length, aspect_ratio, principal_point, skew ] = analyseP( P )
% retrieve intrinsic (from K) and extrinsic (R, Ct) parameters of a 3x4 camera matrix P
% where the intrinsic parameters are: 
% focal_length, aspect_ratio, principal_point and skew
% focal_length = [f_x, f_y], principal_point = [x_0, y_0]
% we have 5 parameters, but we can only solve for 4, because there is an
% arbitrary scale factor involved in f and m_x, m_y
% the "real" f can only be computed when the #pixels in x/y-direction is known

M = P(1:3,1:3);
[K,R] = rq(M);
% scale K by K(3,3) s.t. K(3,3) is 1
% P = [M | -M*Ct] = K*[R | -R*Ct]
K = K/K(3,3);
% get C tilde, inhomogenize, C = [Ct 1], works only for finite cameras
Ct = -inv(M)*P(:,4);
% the following also works
% [U,S,V] = svd(P);
% Ct2 = V(:,end)/V(4,end)


% get more detailed information about P
fx = K(1,1); fy = K(2,2);
focal_length = [fx, fy];
skew = K(1,2);
aspect_ratio = fx/fy;
principal_point = K(1:2,3);
% the following also computes the principal point, and also assigns the
% right direction to the ray passing through C and the principal point
% principal_point2 = M*(det(M)*M(3,:)');
% principal_point2 = principal_point2(1:2)/principal_point2(3)


end

