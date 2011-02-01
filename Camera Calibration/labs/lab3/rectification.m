function R = rectification(H,Iloc)
% computes the rectification of an image. 
% @ H: 3x3 Homography H (e.g. compute it with getH(A,B))
% @ Iloc: location of the transformed image (URL also possible)
% Output: The rectified image R
% edited by Christoph Niemz

im1 = imread(Iloc);

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
yoffset = -min(mbd(2,:)) + 1;

% compute the boundaries
src_rows = max(mbd(2,:));  
src_cols = max(mbd(1,:));  



im2 = uint8(zeros(src_rows + yoffset, src_cols + xoffset, 3));
for x=1:src_cols
    for y=1:src_rows
        a = [x, y, 1]';
        
        b = H * a;
 
        % check if b is an ideal point
        if (b(3,1) ~= 0)
            b = b / b(3,1);
            b = uint16(b);
        
            if (b(1, 1) > 0 && b(1, 1) <= im_cols && b(2, 1) > 0 && b(2, 1) <= im_rows)
                im2(y+yoffset, x+xoffset,:) = im1(b(2,1), b(1,1), :);
            end
        end
    end
end
R = im2;
imshow(im2)


 