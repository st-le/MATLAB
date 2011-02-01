function I = simpson1D(a,b,f,n)
%approximating the integral of f in [a,b] with n data points with composite simpson's
%rule, n should be uneven in order the function to yield the "exact"
%simpsons rule approximation
I = 0;
%if n is even, make it uneven
if (mod(n,2) == 0)
    n = n+1;
end
%generate the x_i

h = (b-a)/(n-1);
sumeven = 0;
sumuneven = 0;
%sum of the even f(x_i)
for i = 1:((n-1)/2)-1
    x(i) = a+(2*i)*h;
    sumeven = sumeven+f(x(i));
end
%sum of the uneven f(x_i)
for i = 1:((n-1)/2)
    x(i) = a+(2*i-1)*h;
    sumuneven = sumuneven+f(x(i));
end
%compute the approximated integral
I = (h/3)*(f(a) + 2*sumeven + 4*sumuneven + f(b));