function [d v] = divdiff(x,y,z)
%Constructing the Interpolation Polynomial with the div. diff. scheme.
y = y';
n = length(y);
D = zeros(n);
D(:,1) = y;
for i = 2:n
   for j = i:n
        D(j,i) = (D(j,i-1) - D(j-1,i-1))./( x(j) - x(j-i+1) );
   end 
end
d = diag(D);
%evaluation of the polynomial at the value z (series z) using horner
v = zeros(1,length(z));
for k = 1:length(z) 
v(k) = d(n);
    for h = (n-1):-1:1
        v(k) = v(k).*(z(k)-x(h))+d(h);
    end
end
