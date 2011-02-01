function s7ex1bexplicit(dt)
%Applying explicit Euler to the problem of the sailing boat
u(1)=0;
v(1)=0;
n = ceil(15/dt);
for t=2:(n+1)
    u(t) = u(t-1) + dt*(10-u(t-1));
    v(t) = v(t-1) + dt*(-0.3*(10-u(t-1)) + 0.2*(3-v(t-1)));
end
t = 1:(n+1);
 plot(t,u,t,v);
 %plot(u,v)