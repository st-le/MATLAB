function [fss v] = cspline(x,y,z)
%computing cubic splines, accepting only 'well formed' input
n = length(x); d=zeros(n-1,1); 
%creating the delta-vector 
for i=1:(n-1)
    d(i) = x(i+1)-x(i);
end
%creating S and y
S = zeros(n); S(1,1)=1; S(n,n)=1; ys=zeros(n,1); ys(1)=0; ys(n)=0;
for j=2:(n-1)
    S(j,j-1) = d(j-1)/6;
    S(j,j)   = (d(j-1)+d(j))/3;
    S(j,j+1) = d(j)/6;
end
for k=2:(n-1)
    ys(k) = ((y(k+1)-y(k))/d(k)) - ((y(k)-y(k-1))/d(k-1));
end
a = diag(S,-1);
b = diag(S);
c = diag(S,1);
fss = tridiagonalsolve(a,b,c,ys);
%evaluate the polynomial at z
m = length(z);
v = zeros(m,1);
for k=1:m
%find interval
i=1;
    while (z(k) > x(i+1))
        i=i+1;
    end
    v(k) = (fss(i)/6).*((((x(i+1)-z(k)).^3)./d(i)) - d(i).*((x(i+1)-z(k)))) + (fss(i+1)/6).*((((z(k)-x(i)).^3)./d(i)) - d(i).*((z(k)-x(i)))) + (y(i)/d(i)).*(x(i+1)-z(k)) + (y(i+1)/d(i)).*(z(k)-x(i));  
end
    