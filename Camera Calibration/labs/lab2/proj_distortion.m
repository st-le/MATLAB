%{ 
    --- Lab 2 --- 
    2.11.2010    
%}
% Setting up point correspondences
% we need 4 pairs of points

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

He = reshape(h, 3, 3)';
H = inv(He);
%%


im1 = imread('house1.bmp');
size(im1)

% select im_rows & im_cols s.t. every point in im is mapped back to a
% source point.
% to do this, we have to calculate the transform H^-1 for each of the 4
% boundary points of the transformed image:
% im1(1,1) im1(1,566) im1(421,1) im1(421,566) , where (height, breadth)

% fixed, obtained from size(im1)
src_rows = 421;
src_cols = 566;

%%
% boundaries of im1
bd = [1,1; 
      1,566; 
      421,1; 
      421,566];

% matrix of backmapped boundaries:
mbd = zeros(3,4);
for i=1:4
    aa = [bd(i,1), bd(i,2), 1]';
    bb = H * aa;
    % inhomogenize bb
    bb = bb / bb(3,1);
    bb = ceil(bb);
    mbd(:,i) = bb;
end
mbd
%Hi = inv(H);
%Hi*mbd(:,3)
%%
% tested, derived from mbd above
im_rows = 600;
im_cols = 750;

im2 = uint8(zeros(im_rows, im_cols, 3));


for x=1:src_cols
    for y=1:src_rows
        % point in transformed image
        a = [x, y, 1]';
        
        % point in original plane
        b = H * a;
        % inhomogenize b
        b = b / b(3,1);
        % add an offset s.t. that the upper right corner is also visible
        b = ceil(b) + [0 20 0]';
        
        if (b(1, 1) > 0 && b(1, 1) <= im_cols && b(2, 1) > 0 && b(2, 1) <= im_rows)
            im2(b(2,1), b(1,1),:) = im1(y, x, :);
        end
    end
end

f = fspecial('gaussian',15);
filteredim2 = imfilter(im2,f);
imshow(filteredim2)


 