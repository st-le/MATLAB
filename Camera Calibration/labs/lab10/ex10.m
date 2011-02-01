clc;
cube = [0 0 0 1; 0 0 4 1; 0 4 0 1; 0 4 4 1; -4 0 4 1; -4 4 4 1; -4 4 0 1; -4 0 0 1]';
mappedcube = [-8.4853 5.1962 1; -3.947 2.5648 1; -5.6569 5.1962 1; -3.0127 3.1877 1; 
                -3.8140 1.3821 1; -3.1142 2.082 1; -5.0212 3.1877 1; -6.5783 2.5648 1]';
            
P = getP(cube, mappedcube)
[ K,R,Ct, focal_length, aspect_ratio, principal_point, skew ] = analyseP( P )