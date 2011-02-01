function I = gaussquadrature(a,b,f,n)
%Gaussian quadrature for n=2,4,6,8 of the function f in [a,b]
%first, change the interval to [-1,1]
h = (b-a)/2;
hs = (b+a)/2;
switch n
    case 2
        x = [-0.5773503 0.5773503];
        I = h*(f(h*x(1)+hs) + f(h*x(2)+hs));
    case 4
        x = [-0.3399810 0.3399810 -0.8611363 0.8611363];
        I = h*(((18+sqrt(30))/36)*(f(h*x(1)+hs) + f(h*x(2)+hs)) + ((18-sqrt(30))/36)*(f(h*x(3)+hs) + f(h*x(4)+hs)));
    case 6
        x = [-0.2386192 0.2386192 -0.6612094 0.6612094 -0.9324695 0.9324695];
        I = h*(0.4679139*(f(h*x(1)+hs) + f(h*x(2)+hs)) + 0.3607616*(f(h*x(3)+hs) + f(h*x(4)+hs)) + 0.1713245*(f(h*x(5)+hs) + f(h*x(6)+hs)));
    case 8
        x = [-0.1834346 0.1834346 -0.5255324 0.5255324 -0.7966665 0.7966665 -0.9602899 0.9602899];
        I = h*(0.3626838*(f(h*x(1)+hs) + f(h*x(2)+hs)) + 0.3137066*(f(h*x(3)+hs) + f(h*x(4)+hs)) + 0.2223810*(f(h*x(5)+hs) + f(h*x(6)+hs)) + 0.1012285*(f(h*x(7)+hs) + f(h*x(8)+hs)));
end