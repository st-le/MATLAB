function [u1 u2 t] = rungekutta4(A,dt,u0s,limit)
%(classical 4th-order) Runge-Kutta method for a system of n ODEs for timestep dt with RHSides represented by A.
%assumption: the integration begins at t=0 and ends at 'limit'

%assign the starting values (u0s is the vector of starting values)
u(:,1) = u0s; 
n = ceil(limit/dt);
for t=2:(n+1)
    %note that k1, k2, k3 and k4 (in general) are vectors. u becomes a matrix.
    k1 = dt*A*u(:,t-1);    
    k2 = dt*A*(u(:,t-1)+(1/2)*k1);
    k3 = dt*A*(u(:,t-1)+(1/2)*k2);
    k4 = dt*A*(u(:,t-1)+k3);
    u(:,t) = u(:,t-1) + (1/6)*(k1 + 2*k2 + 2*k3 +k4);    
end
t = (1:(n+1))*dt;
%return the two functions (only needed for sheet8, in general would need n
%result vectors.
u1 = u(1,1:(n+1));
u2 = u(2,1:(n+1));