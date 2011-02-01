function [Rt, Rmp, Rp, D] = DecompAffine(A)
%{ 
 computes the decomposition of the blockmatrix A of an affine 3x3-transform H_a
 where H_a = [ A  t
               0' 1]
 We can use that A is decomposable using the SVD:
 A = UDV' = UV'VDV' = (UV')(VDV') = (Rt)*(Rmp*D*Rp)
 where U and V are orthogonal matrices & D is a diagonal matrix
 this means that Rt = UV' && Rmp = V && D = D && Rp = V^-1 = V'
 by Christoph Niemz
%}

% D: scaling by D(1,1)(x-direction) and D(2,2)(y-direction)
[U,D,V] = svd(A);

% Rt: Rotation by theta
Rt = U*V';

% Rmp: Rotation by -phi
Rmp = V;

% Rotation by phi
Rp = V';

