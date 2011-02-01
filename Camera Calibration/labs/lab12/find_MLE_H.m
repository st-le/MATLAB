function [ H ] = find_MLE_H( x, xp, mu )
% Gold-Standard algorithm for computing a homography H from sets of m >= 4 
% pt. correspondences according to algorithm 4.3 in the book
% 
% minimizing the Gold-Standard-Error(GSE) means minimizing the reprojection
% error (4.8)
% 
%  parameters:
%     @ x: contains world points x_i
%     @ xp: contains imaged points x_i'
% 	  the points in the two matrices correspond to each other, i.e. H*worldpoints(:,i) = imagepoints(:,i)
%     	worldpoints = | x1		 xn |			imagepoints = | x1'		 xn'|
%     				  | y1	...	 yn |						  | y1' ...	 yn'|
%     				  | w1		 wn |						  | w1'      wn'|
%     @ mu: defines a termination criterion for the iteration. if the
%     difference of the estimated parameters between two iterations is < mu, then we
%     terminate
% Notes: - method is very sensitive to initialization value.
%        - points chosen to initialize H must be in a general position!


m = size(x,2);
if (size(xp) ~= size(x) | size(xp,2) < 4 | m < 4)
    error('number of points must be the same, need at least 4 points!');
end


% 1. Initialization w/ DLT and 4 correspondences IN GENERAL POSITION gives
% first estimate Hhat for H
Hhat = nDLT(x(:,1:m), xp(:,1:m));
% vectorize Hhat
Hhatv = reshape(Hhat,1,9);
% vectorize x (assumption: x already inhomogenized, third component = 1)
initialxh = x(1:2,:);
initialxh = reshape(initialxh, 1,2*m);
% first estimate for xhat are x
P0 = [Hhatv, initialxh]; 

% 2. Minimization of GSE (reprojection error)
% set some options for Levenberg-Marquardt
options = optimset('MaxFunEvals',10000, 'TolX', mu, 'Jacobian', 'off');

[result,resnorm,residual,exitflag,output] = lsqnonlin(@(P)obj_fun(P,x,xp,m), P0,[],[],options);

H = reshape(result(1:9),3,3);
% show some information
output;

H = H/H(3,3); 

function  F  = obj_fun( P, x, xp, m )
% represents the objective function for the reprojection error
% P = [Hhat1, ..., Hhat9, xh1, yh1, xh2, yh2 ...., xhm, yhm]
% Hhat: estimate of H, xh (=xhat) : estimate of x
% 2m + 9 parameters

% get H
H = reshape(P(1:9),3,3);
   
% assuming pts x,xp are already inhomogenized
x = x(1:2,:);
xp = xp(1:2,:);

% obtain xh 
xh = P(10:end);
xh = reshape(xh,2,m);
% xh already inhomogenized
xh = [xh; ones(1,m)];
% obtain xhp, inhomogenize all xhp
xhp = H * xh;
xhp = xhp./(repmat(xhp(3,:),3,1));

xh = xh(1:2,:);
xhp = xhp(1:2,:);
% calculate error function 
i = 1:m;
dworld = (x(1,i) - xh(1,i)).^2 + (x(2,i) - xh(2,i)).^2;
dimage = (xp(1,i) - xhp(1,i)).^2 + (xp(2,i) - xhp(2,i)).^2;

F = dworld + dimage; % error in both images  

%{
if nargout > 1 % two output args -> compute Jacobian at P
    J = []
end
%}
