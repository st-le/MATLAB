function multstepint2(x0,y0)
%multistep method used for the predator-prey model of assignment 5, this
%here is assignment 6
x = [x0 x0];
y = [y0 y0];
A=2; B=1; C=3; D=0.2;
for t=3:201
    x(t) = x(t-1) + 0.001*1.5*(A - B*y(t-1) - x(t-1))*x(t-1) - 0.001*0.5*(A - B*y(t-2) - x(t-2))*x(t-2);
    y(t) = y(t-1) + 0.001*1.5*(C*x(t-1) - D - y(t-1))*y(t-1) - 0.001*0.5*(C*x(t-2) - D - y(t-2))*y(t-2);
end
t=[1:201];
%plot(t,x,t,y,'r');
% hold all;
plot(x,y)