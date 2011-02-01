function I = trapezoid1D(a,b,f,n)
%approximate the Integral I in the boundaries [a,b] with n intervals (i.e. n+1 data points) with
%the composite trapezoidal rule
%TESTED AND CORRECT!
I = 0;
n=n+1;
%generate the x_i
x=zeros(1,n);
h = (b-a)/(n-1);
for i = 1:n
    x(i) = a+(i-1)*h;
end
%sum up the integral pieces
for i=1:(n-1)
    I = I + 0.5*h*(f(x(i))+f(x(i+1)));
end