function [H,R] = rectification(A,B,Iloc)
% computes the rectification of an image. 
% @ A,B: 2x4 matrices containing corresponding points of the two images
% @ Iloc: location of the transformed image
% Output: Homography H and the rectified image R
% edited by Christoph Niemz



if nargin == 0
% Setting up point correspondences

% house2.bmp - source image
A = [496, 153;
     495, 247;
     325, 246;
     325, 150];
     
     
%house1.bmp - transformed image     
B = [445, 102;
     449, 181;
     321, 175;
     317, 86];        

im1 = imread('house1.bmp');
else
    im1=imread(Iloc);
end


A = A';
B = B';

%%
% Create matrix C
C = [];
for j=1:4
    part  = [A(1, j), A(2, j), 1, 0,       0,       0; 
             0,       0,       0, A(1, j), A(2, j), 1];
          
    C_cur = [part, -1 * B(:, j) * A(:,j)', -1*B(:,j)];
    
    C = vertcat(C, C_cur);
end

% Solve for h
h = null(C);

H = reshape(h, 3, 3)';


%%


im1 = imread('house1.bmp');
im1size = size(im1);

im_rows = im1size(1);
im_cols = im1size(2);

% boundaries of im1
bd = [1,1; 
      1,im_cols; 
      im_rows,1; 
      im_rows,im_cols];

% use H^-1 to compute the coordinates of the inverted boundaries
mbd = zeros(3,4);
Hi = inv(H);
for i=1:4
    aa = [bd(i,2), bd(i,1), 1]';
    bb = Hi * aa;
    % inhomogenize bb
    bb = bb / bb(3,1);
    bb = ceil(bb);
    mbd(:,i) = bb;
end

% compute the offset s.t. the image is not translated
xoffset = -min(mbd(1,:)) + 1;
yoffset = -min(mbd(2,:));

% compute the boundaries
src_rows = max(mbd(2,:));
src_cols = max(mbd(1,:));



im2 = uint8(zeros(src_rows, src_cols, 3));
for x=1:src_cols
    for y=1:src_rows
        a = [x, y, 1]';
        
        b = H * a;
        
        b = b / b(3,1);
        b = uint16(b);
        
        if (b(1, 1) > 0 && b(1, 1) <= im_cols && b(2, 1) > 0 && b(2, 1) <= im_rows)
            im2(y+yoffset, x+xoffset,:) = im1(b(2,1), b(1,1), :);
        end
    end
end
R = im2;
imshow(im2)


 