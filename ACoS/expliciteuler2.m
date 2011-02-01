function expliciteuler2
x(1)=100;
y(1)=50;
A=2; B=1; C=2; D=3;
for t=2:201
    x(t) = x(t-1) + 0.001*(A - B*y(t-1) - x(t-1))*x(t-1);
    y(t) = y(t-1) + 0.001*(C*x(t-1) - D - y(t-1))*y(t-1);
end
% t=[1:201];
% plot(t,x,t,y,'r');
plot(x,y);