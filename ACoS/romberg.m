function [I T] = romberg(a,b,f,n,k)
%compute the approximate integral of f in the domain [a,b] using romberg
%integration, which uses richardson extrapolation
%TESTED AND CORRECT!
R=zeros(n);
I=0;
%generate the first column, using the trapezoidal rule
for i=1:n
    R(i,1) = trapezoid1D(a,b,f,2^(i-1));
end
%compute the rest of the scheme
for j=2:n
    for i=j:n
        R(i,j) = ((4^(j-1))*R(i,j-1) - R(i-1,j-1))/((4^(j-1))-1);
        if i==j 
            I = [I R(i,j)]
        end
    end
end
%I=R(n,k);
T=R(n,1);