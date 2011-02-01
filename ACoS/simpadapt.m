function [I L count] = simpadapt(a,b,f,epsilon,list,cnt)
%adaptive quadrature with simpson's rule, L contains the list of all used
%data points, count is the number of function evaluations
h = (b-a);
x = [a a+h/4 a+h/2 a+(3*h/4) b];
L = [a];
count = 5;
fx1 = f(x(1));
fx3 = f(x(3));
fx5 = f(x(5));

%compute S_0_h
S_i = (h/6)*(fx1 + 4*fx3 + fx5);

%compute S_0_(h/2)
S_i_2 = (h/12)*(fx1 + 4*f(x(2)) + 2*fx3 + 4*f(x(4)) + fx5);

%error estimate using richardson (S_1_(h/2)) where
%S_1_(h/2) = (16*S_i_2-S_i)/15)
S1 = (16*S_i_2-S_i)/15;

delta = abs(S1-S_i);
if (delta > epsilon)
    h = (b-a)/2;
    [I1 L1 c1] = simpadapt(f,a,a+h,epsilon/2,L,count);
    [I2 L2 c2] = simpadapt(f,a+h,b,epsilon/2,L,count);
    I = I1+I2;
    L = [L1 L2];
%compute the number of function evaluations, there are 5 function
%evaluations in each simpadapt call.
    count=c1+c2;
else
    I = S1;
end
