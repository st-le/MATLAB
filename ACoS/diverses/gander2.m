function y = gander2(x,d,z)
%evaluation of newton's interpolation polynomial with horner.
n=length(x)-1;
y = d(n+1);
for i=n:-1:1
    y=y.*(z-x(i))+d(i);
end