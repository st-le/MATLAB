function  P = getP( worldpoints, imgpoints )
%{
   VERIFIED; WORKS CORRECTLY  
   implements the DLT according to algorithm 4.1
 Parameters:
	@ imagepoints: points in the world plane
	@ worldpoints: points in the image plane
	@ numpoints: number of corresponding points, should be >= 4
	the points in those two matrices correspond to each other, i.e. H*worldpoints(:,1) = imagepoints(:,1)
	Note: it should hold that numpoints = # imagepoints = # worldpoints
	worldpoints = | x1		 xn |			imagepoints = | x1'		 xn'|
				  | y1	...	 yn |						  | y1' ...	 yn'|
				  | w1		 wn |						  | w1'      wn'| 
%}

if size(imgpoints) ~= size(worldpoints)
    error('number of points must be the same!');
end

% get number of points
m = size(worldpoints,2);
n = 12;
A = zeros(2*m,n);
% Fill A

  for i = 1:m
    xip = imgpoints(1,i);
    yip = imgpoints(2,i);
    wip = imgpoints(3,i);
    
    % xi is a 4D homogenous vector
    xi = worldpoints(:,i);
    
    Ai = [ 0, 0, 0, 0,   -wip * xi',   yip * xi' ;
           wip * xi',   0, 0, 0, 0,  -xip * xi' ];

    A = [ A ; Ai ];
  end;


% compute SVD of A
[U,D,V] = svd(A);
h = V(:,n);
% scale H s.t. P(3,4) = 1
h = h/h(n);
P = reshape(h,4,3)';


