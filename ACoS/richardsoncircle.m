function C = richardsoncircle(n,k)
%computing the circumference of a circle using richardson extrapolation,
%where n is the number of the step bisections.
%we use PI TO APPROXIMATE PI?
if k>n
    error('k has to be <= n!');
end
R = zeros(n);
%generate the first column 
for i=1:n
    R(i,1) = (2^i)*sin(pi/(2^(i-1)));
    %R(i,1) = 2*pi - 1/3*((pi^3)/(2^(2*(i-1))));
end
%generate the rest of the richardson scheme
for j=2:n
    for i=j:n
        R(i,j) = ((4^j)*R(i,j-1) - R(i-1,j-1))/((4^j)-1);
    end
end
C = R(n,k);
