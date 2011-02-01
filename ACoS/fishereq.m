function [pt1 x] = fishereq(dx,k,D,t_f)
%simulate the evolution of the dominant gene given by Fisher's equation 
%at the final times t_f and the space interval [0,1]
%using explicit Euler and Finite Differences (for the 2nd derivative of p)
dt=(dx^2)/(20*D);
n=ceil(1/dx);
m=ceil(t_f/dt);

%using only two vectors for memory reasons:
pt1(1:ceil(n/4)) = 1;
pt1((ceil(n/4)+1):n) = 0;
pt=pt1;
for j=2:m
    for i=2:(n-1)       
        pt1(i) = pt(i) + dt*D*(pt(i-1)+pt(i+1)-2*pt(i))/(dx^2) + dt*(k*pt(i)*(1-pt(i)));
    end
    pt = pt1;
end
x=0:dx:1;
pt1=[1 pt1];
