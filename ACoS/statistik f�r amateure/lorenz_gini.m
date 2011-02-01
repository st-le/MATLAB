function [G f] = lorenz_gini(x)
%print the lorenz curve of a sample and return the gini-coefficient
%I will use 2 methods, one of which offers the student the opportunity  to integrate by hand
%with the interpolation polynomial, the other will just compute the area
%in between the lorenz curve and the perfect equality function with the
%trapezoidal rule
if sum(x < 1) == 0
    x = 100*(x/sum(x));
end
n=length(x);
x=sort(x);
z=0;
%compute the cumulative distribution function (the "Lorenz Curve")
for i=1:n
    y(i) = x(i) + z;
    z = z + x(i);
end
y = [0 y];

%1. trapezoidal rule
A=0;
h=100/n;
for i=1:n
    A = A + (h/2)*(y(i)+y(i+1));
end
G = (5000-A)/5000;
%plot
plot(0:h:100,y,0:100,0:100);

%2. divided differences
%d = divdiff(1:n,x,[]);