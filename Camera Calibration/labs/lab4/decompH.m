function [ Hs, Ha, Hp ] = decompH( H )
% decomposes a general matrix H = Hs*Ha*Hp
% more precisely:
% H = Hs*Ha*Hp = [s*R t  * [ A  0  * [ I  0
%                 0 0 1]    0 0 1]     v' w]

% from H, we can simply derive Hp -> v',w known
Hp = [1 0 0  
      0 1 0
      H(3,:)];

% Hs*Ha = H*Hp^-1
HsHa = H * inv(Hp);

% we now also know t
t = HsHa(1:2,3);

% get the 2x2 s*R*A part of HsHa
E = HsHa(1:2,1:2);

% decompose Hs*Ha to find sRA
[R U] = qr(E);

% get the factor s
s = sqrt(det(U))

% get the affine part
A = U ./ s;

Hs = [s*R t
      0 0 1];

Ha = [ A(1,:) 0
       A(2,:) 0
       0 0    1];

end

