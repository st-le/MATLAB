function [e1 e2] = s3_exercise1_3
%no extrapolation, i=1,...,10
e1 = zeros(10,1);
for i=1:10
    e1(i) = abs((2*pi-richardsoncircle(i,1))/(2*pi));
end
%i=5 and k=0,...,4
e2 = zeros(5,1);
for k=1:5
    e2(k) = abs((2*pi-richardsoncircle(5,k))/(2*pi));
end