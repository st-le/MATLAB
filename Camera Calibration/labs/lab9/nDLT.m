function  H = nDLT( worldpoints, imgpoints )
%{
    computes the normalized DLT algorithm according to 
    according to algorithm 4.2 in the book

    parameters:
    @ worldpoints: contains points x_i
    @ imgpoints: contains points x_i'
	the points in those two matrices correspond to each other, i.e. H*worldpoints(:,1) = imagepoints(:,1)
	Note: it should hold that numpoints = # imagepoints = # worldpoints
	worldpoints = | x1		 xn |			imagepoints = | x1'		 xn'|
				  | y1	...	 yn |						  | y1' ...	 yn'|
				  | w1		 wn |						  | w1'      wn'| 
%}
if (size(imgpoints) ~= size(worldpoints) | size(imgpoints,2) < 4 | size(worldpoints,2) < 4)
    error('number of points must be the same, need at least 4 points!');
end

% normalize x
[normx, T] = normalizepts(worldpoints);

% normalize x'
[normxp, Tp] = normalizepts(imgpoints);


% Apply DLT
Ht = DLT(normx, normxp);

% Denormalization: H = T'^-1 * Ht * T
H = inv(Tp)*Ht*T;

H = H/H(3,3);

end