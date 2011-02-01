function s7ex1dimplicit(dt)
%Applying implicit Euler to the sailing boat problem,
%converges only for dt < 1 (according to banach's fixed point theorem)
u(1)=0;
v(1)=0;
n=15/dt;
for t = 2:(n+1)
    c=2;
    u(t)=0;

%fixed point iteration for u
        while (abs(u(t)-c) > 10e-8)
            c = u(t);
            u(t) = u(t-1) + 10*dt*(10-u(t))

        end
    v(t)=10;
    d=1; 

 %fixed potnt iteration for v
        while (abs(v(t)-d) > 10e-8)
            d = v(t);
            v(t) = v(t-1) + dt*(-0.3*(10-u(t-1)) + 0.2*(3-v(t-1)));
        end
end
t=1:(n+1);
u
v
plot(t,u,t,v);