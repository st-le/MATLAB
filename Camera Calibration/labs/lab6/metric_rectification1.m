function [ I ] = metric_rectification1( Iloc, l1,l2,m1,m2 )
% removes the affine distortion of an already affinely rectified image
% according to Example 2.26 in Multiple View Geometry
% @Iloc: affinely rectified image
% @(l1,m1) (l2,m2), imaged line pairs that are supposed to be orthogonal in the world plane


% construct equation system, 
A = [ l1(1)*m1(1), l1(1)*m1(2)+l1(2)*m1(1),  l1(2)*m1(2); 
      l2(1)*m2(1), l2(1)*m2(2)+l2(2)*m2(1),  l2(2)*m2(2) 
    ];

% solving for s := (s11 s12 s22)
s = null(A);

% symmetric matrix KKt
KKt = [s(1) s(2)
       s(2) s(3)];

% get K with cholesky
K = chol(KKt,'lower');

% with K, we can construct H_a
Ha = [K [0 0]'
       0 0  1 ];

% compute inverse to remove affine distortion
Hai = inv(Ha);

I = rectification(Hai, Iloc);

end
