function [ R, Q ] = rq( A )
% computes the RQ-decomposition of A using QR of A
% RQ decomposition is Gram-Schmidt orthogonalization of rows of A, started from the last row of A.
% row -> transpose
% last = flipud
[Q,R] = qr(flipud(A)');
R = flipud(R');
R = fliplr(R);
Q = flipud(Q');


end

