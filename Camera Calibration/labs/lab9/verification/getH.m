function H = getH(A,B)
% returns the 3x3 Homography for the 2 point correspondence matrices A and B:
% A: 4 points from source image
% B: 4 points from transformed image (camera view)
% A = [x1 x2 x3 x4   B = [x1' x2' x3' x4'
%      y1 y2 y3 y4]       y1' y2' y3' y4']


% Create matrix C
C = [];
for j=1:4
    part  = [A(1, j), A(2, j), 1, 0,       0,       0; 
             0,       0,       0, A(1, j), A(2, j), 1];
          
    C_cur = [part, -1 * B(:, j) * A(:,j)', -1*B(:,j)];
    
    C = vertcat(C, C_cur);
end

% Solve for h; null(C) works because we solve a homogenous system Ax = 0
h = null(C);

H = reshape(h, 3, 3)';

H = H/H(3,3);