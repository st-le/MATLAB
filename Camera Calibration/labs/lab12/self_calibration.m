function [ A,Rt ] = self_calibration( model_pts, img_pts )
%{ 
    Performs self-calibration as proposed in "A Flexible New Technique for
    Camera Calibration" by Zhengyou Zhang

    params:
    @ model_pts: the 2D-coordinates of the planar object in the world
    @ img_pts: the 2D-coordinates of the numimages images that were taken of the object
    @ numimages: the number of images that were taken of the planar object

    	model_pts M = | x1		 xn |		  img_pts(:,:,i) m = | x1'		 xn'|
    				  | y1	...	 yn |						     | y1' ...	 yn'|

%}

% get number of images
n = size(img_pts,3)
numpoints = size(model_pts,2);

% homogenize the model points
model_pts = [model_pts; ones(1,numpoints)];
% homogenize the image points
for i=1:n
    img_pts(3,:,i) = ones(1,numpoints);
end

% I. ALGEBRAIC SOLUTION
% 1. compute a Homography H for each point pair, add the corresponding 
% equations to the equation system Vb = 0
V = [];
% Hi contains one estimated Homography for each image
Hi = [];
for i=1:n
    H = find_MLE_H(model_pts, img_pts(:,:,i), 0.001);
    % columns vectors of H
    h1 = H(:,1); h2 = H(:,2); h3 = H(:,3);
    v12 = [h1(1)*h2(1), h1(1)*h2(2) + h1(2)*h2(1), h1(2)*h2(2), h1(3)*h2(1) +  h1(1)*h2(3), h1(3)*h2(2) +  h1(2)*h2(3), h1(3)*h2(3)];
    v11 = [h1(1)*h1(1), h1(1)*h1(2) + h1(2)*h1(1), h1(2)*h1(2), h1(3)*h1(1) +  h1(1)*h1(3), h1(3)*h1(2) +  h1(2)*h1(3), h1(3)*h1(3)];
    v22 = [h2(1)*h2(1), h2(1)*h2(2) + h2(2)*h2(1), h2(2)*h2(2), h2(3)*h2(1) +  h2(1)*h2(3), h2(3)*h2(2) +  h2(2)*h2(3), h2(3)*h2(3)];
    Hi = [Hi, h1, h2, h3];
    
    V = [V; v12; (v11 - v22)]; 
end

% 2. solve Vb = 0 by getting nullspace of V
[U,D,W] = svd(V);
b = W(:,6);

% 3. get intrinsic parameters from b (see Appendix B for the formulas)
v0 = (b(2)*b(4) - b(1)*b(5))/(b(1)*b(3) - b(2).^2);
lambda = b(6) - (b(4).^2 + v0*(b(2)*b(4) - b(1)*b(5)))/b(1);
alpha = sqrt(lambda/b(1));
beta = sqrt((lambda*b(1))/(b(1)*b(3) - b(2).^2));
gamma = (-b(2)*(alpha^2)*beta)/lambda;
u0 = ((gamma*v0)/beta) - b(4)*(alpha^2)/lambda;

% Note: A is our known K
A = [alpha gamma u0;
     0     beta  v0;
     0     0     1];
Ainv = inv(A);
 
% 4. get extrinsic parameters for each image as initial guesses Ri, ti, i=1..n
% build Ri = [r1, r2, ... , r3] where ri = [a, b, c], is a 3-vector
%       ti = [t1, t2, ... , tn]
Ri = [];
ti = [];
for i=1:n
    h1 = Hi(:,i); h2 = Hi(:,i+1); h3 = Hi(:,i+2);
    lambda = 1/(norm(Ainv*h1));
    r1 = lambda*Ainv*h1;
    r2 = lambda*Ainv*h2;
    r3 = cross(r1,r2);
    % estimate the rotation matrix Q that is nearest to R.
    r = estimate_r([r1,r2,r3]);
    Ri = [Ri, r];
    
    t = lambda*Ainv*h3;
    ti = [ti, t];
end

% the initial guess is the parameters we just calculated in the closed-form 
P0 = [A, Ri, ti];

% II. ITERATIVE REFINEMENT (MINIMIZING THE GEOMETRIC ERROR)
% we minimize the sum of error sums

options = optimset('LargeScale','off','MaxFunEvals',10000, 'TolX', 0.01, 'Jacobian', 'off', 'LevenbergMarquardt','on');
[result,resnorm,residual,exitflag,output] = lsqnonlin(@(P)errorfunc(P, model_pts, img_pts), P0,[],[],options);

% get A, Ri, ti from P
A = result(1:3,1:3);
Ri = result(:,4:(3+n));
ti = result(:,(4+n):end);

% construct rotation + translation matrices from result
Rt = [];
for i=1:n
    r1 = Ri(1,i);
    r2 = Ri(2,i);
    r3 = Ri(3,i);
    Rtemp = [cos(r2)*cos(r1)                            sin(r2)*cos(r1)                         -sin(r1)         ; 
            -sin(r2)*cos(r3)+cos(r2)*sin(r1)*sin(r3)    cos(r2)*cos(r3)+sin(r2)*sin(r1)*sin(r3)  cos(r1)*sin(r3) ;
             sin(r2)*sin(r3)+cos(r2)*sin(r1)*cos(r3)   -cos(r2)*sin(r3)+sin(r2)*sin(r1)*cos(r3)  cos(r1)*cos(r3)];
    
    Rt = [Rt, Rtemp, ti(:,i)];
end


output
norm(residual)

function f = errorfunc(P, M, m)
% return the sum over all images i=1:n
% assuming pts M, m are already inhomogenized (last component == 1)

% get number of images
n = size(m,3);
% numpoints = size(m,2);

% get A, Ri, ti from P
A = P(1:3,1:3);
Ri = P(:,4:(3+n));
ti = P(:,(4+n):end);

% create matrices out of the parameters ri
R = [];
for i=1:n
    r1 = Ri(1,i);
    r2 = Ri(2,i);
    r3 = Ri(3,i);
    % use Rodrigues formula
    Rtemp = [cos(r2)*cos(r1)                            sin(r2)*cos(r1)                         -sin(r1)         ; 
            -sin(r2)*cos(r3)+cos(r2)*sin(r1)*sin(r3)    cos(r2)*cos(r3)+sin(r2)*sin(r1)*sin(r3)  cos(r1)*sin(r3) ;
             sin(r2)*sin(r3)+cos(r2)*sin(r1)*cos(r3)   -cos(r2)*sin(r3)+sin(r2)*sin(r1)*cos(r3)  cos(r1)*cos(r3)];
    R = [R; Rtemp];
end

% sum up the error for all images (the outer sum and the squaring is done by matlab)
imgpts = [];
mhat = [];

for i=0:(n-1)
    % get the R for this image
    Rcur = R((3*i)+1:(3*i)+3, :);
    % append translation component
    Rt = [Rcur(:,1:2), ti(:,i+1)];
    % compute camera mapping for constant A, M and varying Rt
    mt = A*Rt*M;
    % inhomogenize
    mt = [mt(1,:)./mt(3,:); mt(2,:)./mt(3,:); mt(3,:)./mt(3,:)];
    mhat = [mhat; mt(1,:); mt(2,:)];
    % expand measured image points matrix
    imgpts = [imgpts; m(1,:,i+1); m(2,:,i+1)];
end
f = imgpts - mhat;

function r = estimate_r(R)
% calculates the nearest rotation matrix to R according to the Frobenius norm
% returns 3-vector r, which contains the 3 rotation angles
[U,S,V] = svd(R);
Q = U*V';
% extract parameters (3 rotation angles) from Q using Rodrigues angles
r = zeros(3,1);
r(1) = -asin(Q(1,3));
r(2) = asin(Q(1,2)/cos(r(1)));
r(3) = asin(Q(2,3)/cos(r(1)));


