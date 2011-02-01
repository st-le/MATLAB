function x = tridiagonalsolve(a,b,c,d)
%My Implementation of the TDMA

%modify the coefficients
n=length(b);
c(1) = c(1)/b(1);
d(1) = d(1)/b(1);
for i = 2:(n-1)
    div  = (b(i)-c(i-1)*a(i-1));
    c(i) = c(i)/div;
    d(i) = (d(i)-d(i-1)*a(i-1))/div;
end
d(n) = (d(n)-d(n-1)*a(n-1))/(b(n)-c(n-1)*a(n-1));

%backward substitution
x(n)=d(n);
for i=(n-1):-1:1
    x(i) = d(i) - c(i)*x(i+1);
end