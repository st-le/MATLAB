function [e r t] = s3_ex2_4
%compare relative error of trapezoid vs. romberg 
e = zeros(17,1);
t = zeros(17,1);
r = zeros(17,1);
f = inline('1/(1+x)');
for i=1:17
    [Ri T] = romberg(0,1,f,i,i);
    t(i) = abs((log(2) - T)/log(2));
    r(i) = abs((log(2) - Ri)/log(2));
    e(i) = abs(r(i)- t(i));
end
plot(1:17,e,1:17,t,1:17,r);
