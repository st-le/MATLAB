function s7ex1bimplicit(dt)
%Applying implicit Euler to the sailing boat problem
u(1)=0;
v(1)=0;
n=ceil(15/dt);
for t = 2:(n+1)
    u(t) = (u(t-1) + 10*dt)/(1 + dt);
    v(t) = (v(t-1) - dt*(2.4 + 0.3*u(t)))/(1+0.2*dt);
end
t=1:(n+1);
plot(t,u,t,v);