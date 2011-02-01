% Handout 2, problem 4
% solving C*h = r to get H (and H^-1)
function b = ex2(x);
% 4 pts. from original / rectified image ???
B = [44,  147, 1;
     43,  254, 1;
     495, 153, 1;
     495, 246, 1]; 
% 4 pts. from mapped image ???
A = [51,  58,1;
     49, 160,1;
     444, 102, 1;
     449, 180, 1];
A = A'; 
B = B';

%%
C = [];
r = [];
for i=1:4
    C_cur = [A(1,i), A(2,i), 1, 0 0 0 0 0 0
             0 0 0, A(1,i), A(2,i), 1, 0 0 0 
             0 0 0 0 0 0, A(1,i), A(2,i), 1];

    C = vertcat(C,C_cur);
    r_cur = [B(1,i); B(2,i); 1];
    r = vertcat(r, r_cur);
end
h = C\r;
H = reshape(h, 3,3)';
% read photographed image
im1 = imread('http://www.robots.ox.ac.uk/~vgg/hzbook/all_figs/gif/fig1.4a.gif');
% KNOWN RESULT (INVERSE): im2 = imread('D:\Dokumente und Einstellungen\Universität Konstanz\Eigene Dateien\MATLAB\Camera Calibration for CV\fig1.4b.bmp');
% computed INVERSE:
im2 = uint8(zeros(421,566,3));
size(im1)
for x=1:566
    for y=1:422
       a = [x,y,1]';
       b = H*a;
       b = b/b(3,1);
       b = uint16(b); 
       if (b(1,1) > 0 && b(1,1) <= 566) && (b(2,1) > 0 && b(2,1) <= 421)           
           im2(y,x,:) = im1(b(2,1), b(1,1),:); 
       end
    end
end

imshow(im2)