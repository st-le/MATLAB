function [ result ] = rGCD(x, y) 
% rGCD(x,y) returns the greatest common denominator of x and % y 
temp = mod(x, y); 
if ( temp == 0) 
   result = y; 
else 
   result = rGCD(y, temp); 
end 

