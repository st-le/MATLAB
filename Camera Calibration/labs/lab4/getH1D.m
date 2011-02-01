function H  = getH1D( A, B )
% returns the 2x2 Homography for the 2 point correspondence matrices A and B:
% A: 3 points on a line from source image
% B: 3 points on a line from transformed image (camera view)
% A = [x1 x2 x3]   B = [x1' x2' x3']

% Fill C, analogously to getH2D
x1= A(1); x2 = A(2);x3=A(3);
x1p = B(1); x2p = B(2); x3p = B(3);


C = [-1*x1, -1, x1p*x1, x1p; 
     -1*x2, -1, x2p*x2, x2p;
     -1*x3, -1, x3p*x3, x3p;];

h = null(C);
H = reshape(h,2,2)';

end
