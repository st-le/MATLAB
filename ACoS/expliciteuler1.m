function expliciteuler1(x0,y0)
%not a general explicit euler function, solution to assignment5, ex2.1
x(1) = x0;
y(1) = y0;
A=0.1; B=0.005; C=0.001; D=0.2;
for t=2:201
    x(t) = x(t-1) + (A - B*y(t-1))*x(t-1);
    y(t) = y(t-1) + (C*x(t-1) - D)*y(t-1);
end
t=[1:201];
%plot(t,x,t,y,'r');
% hold all;
% plot(x,y,'o')