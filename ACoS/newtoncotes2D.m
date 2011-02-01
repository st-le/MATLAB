function [I J] = newtoncotes2D(n,numpoints,a,b,c,d,f)
%2D-Newton-Cotes with given f(x,y) for different n:
%f: function to be numerically integrated (in inline notation)
%a,b: integration boundaries x-wise
%c,d: integration boundaries y-wise
%n=1: Trapezoidal rule 
%n=2: Simpson's rule 
%interval size x and y-wise
h = (b-a)/(numpoints-1);
k = (d-c)/(numpoints-1);
I = 0;
switch n
    case 1
        %generate x and y
        x = zeros(1,numpoints);
        y = zeros(1,numpoints);
        for i=1:numpoints
            x(i) = a+(i-1)*h;
            y(i) = c+(i-1)*k;
        end
        for i = 1:(numpoints-1)
            for j=1:(numpoints-1)
            I = I + ((h*k)/4)*( f(x(i),y(j)) + f(x(i),y(j+1)) + f(x(i+1),y(j)) + f(x(i+1),y(j+1)) );
            end
        end
    case 2
        %generate x and y
        x = zeros(1,(2*numpoints)-1);
        y = zeros(1,(2*numpoints)-1);
        h1 = (b-a)/(2*numpoints-2); 
        k1 = (d-c)/(2*numpoints-2);
        for i=1:((2*numpoints)-1)
            x(i) = a+(i-1)*h1;
            y(i) = c+(i-1)*k1;
        end
        for i = 1:2:(2*numpoints-2)
            for j = 1:2:(2*numpoints-2)
            %integrate
            I = I + ((h*k)/36) * ( f(x(i),y(j)) + 4*f(x(i),y(j+1)) + f(x(i),y(j+2)) + 4*f(x(i+1),y(j)) + 16*f(x(i+1),y(j+1)) + 4*f(x(i+1),y(j+2)) + f(x(i+2),y(j)) + 4*f(x(i+2),y(j+1)) + f(x(i+2),y(j+2)));
            end
        end
end